ALTER PROCEDURE [dbo].[USP_OnlineCallback_I]
    @TEL_NO VARCHAR(50)
    , @DNIS VARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON

    DECLARE @RETURN VARCHAR(10)
    DECLARE @RETURN_MSG VARCHAR(200)

	IF (ISNULL(@TEL_NO, '') = '' OR ISNULL(@DNIS, '') = '')
		BEGIN
            SET @RETURN = '10'
            SET @RETURN_MSG = '정보 부족'
        END
	ELSE
		BEGIN
            SET @TEL_NO = REPLACE(@TEL_NO, '-','')


			-- 1.콜백 제한 갯수, DOMAIN_NUM
			DECLARE @SC_LIMIT INT
			DECLARE @SC_GROUP INT
			DECLARE @MARIADB_QUERY VARCHAR (4000)

			-- SELECT @SC_LIMIT = SC_LIMIT, @SC_GROUP = SC_GROUP
			-- FROM OPENQUERY(CTI_IMS, 'SELECT SC_LIMIT, SC_GROUP FROM ims.mng_ivr_scenariocallback WHERE sc_callback = 36') -- 실서버용
			-- FROM ims.dbo.mng_ivr_scenariocallback WHERE sc_callback = 36 -- 테스트서버용


			SELECT @SC_GROUP = Branch_Code FROM CTI_IMS...code_dnis_branch WHERE DNIS = @DNIS 


			-- SELECT @MARIADB_QUERY = 'SELECT @SC_GROUP = Branch_Code FROM OPENQUERY(CTI_IMS, ''SELECT Branch_Code FROM ims.code_dnis_branch WHERE Dnis = ''''' + @DNIS + ''''''')'
			-- EXEC (@MARIADB_QUERY)

			SELECT @SC_LIMIT = SC_LIMIT
			FROM CTI_IMS...mng_ivr_scenariocallback WHERE sc_callback = @SC_GROUP

			-- 2. 현재 콜백수
			DECLARE @CUR_CB_CNT INT

			SELECT @CUR_CB_CNT = COUNT(1) 
			FROM dbo.tblCTI_Callback WITH(READUNCOMMITTED) 
			WHERE regDate >= CONVERT(VARCHAR(10), GETDATE(), 121)
			AND DOMAIN_NUM = @SC_GROUP
			AND endDate IS NULL


			-- 3. 1시간내 중복 등록 체크
			DECLARE @TIME_DUP_CNT INT
			DECLARE @LAST_REGDT DATETIME

			SELECT @TIME_DUP_CNT = COUNT(1), @LAST_REGDT = MAX(regDate)
			FROM dbo.tblCTI_Callback WITH(READUNCOMMITTED)
			WHERE inputNum = @TEL_NO
			AND regDate >= DATEADD(HOUR, -1, GETDATE())
			AND endDate IS NULL

			-- SET @CUR_CB_CNT = 10

			-- 콜백 제한 초과
			IF (@SC_LIMIT <= @CUR_CB_CNT ) 
				BEGIN
					SET @RETURN = '02'
					SET @RETURN_MSG = '콜백 제한 갯수 초과 (제한 설정수 : '+ RTRIM(LTRIM(STR(@SC_LIMIT))) +', 현재콜백수 : '+ RTRIM(LTRIM(STR(@CUR_CB_CNT))) +')'
				END
			-- 1시간내 중복 체크
			ELSE IF(@TIME_DUP_CNT > 0)
				BEGIN
					SET @RETURN = '01'
					SET @RETURN_MSG = '1시간내 동일 전화번호 중복 발생 ('+ CONVERT(VARCHAR(30), @LAST_REGDT, 121) +')'
				END
			ELSE
				BEGIN

					-- 실제 CALLBACK 저장
					INSERT INTO dbo.tblCTI_Callback(domain_num, skind, CallerID, inputNum, CalleeID, regDate, orderNum, isWork, endDate, contents, forcedComplete, dnis, callid, SyncStat, CbType)
					SELECT @SC_GROUP, 0, @TEL_NO, @TEL_NO, NULL, GETDATE(), 0, 0, NULL,  NULL, NULL, @DNIS, '', 0, '01'

					SET @RETURN = '00'
					SET @RETURN_MSG = '신청완료'
				END
        END

	

    -- 최종 결과 
    SELECT @RETURN AS RESULT, @RETURN_MSG AS RESULT_MSG

    /* INSERT 확인
    , @SC_GROUP AS domain_num, 0 AS skind, @TEL_NO AS CallerID, @TEL_NO AS inputNum
    , '' AS CalleeID, GETDATE() AS regDate, 0 AS orderNum, 0 AS isWork, NULL AS endDate, NULL AS contents
    , NULL AS forcedComplete, @DNIS AS dnis, '' AS callid, 0 AS SyncStat
    */
END
GO