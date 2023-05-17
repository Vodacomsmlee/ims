/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 10.4.7-MariaDB-log : Database - ims
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/* Procedure structure for procedure `USP_Mnt_Mntng_Api_WaitCalls_S` */

/*!50003 DROP PROCEDURE IF EXISTS  `USP_Mnt_Mntng_Api_WaitCalls_S` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ims`@`%` PROCEDURE `USP_Mnt_Mntng_Api_WaitCalls_S`(
v_Dept_No VARCHAR(4000)
)
BEGIN
	-- 약국 서비스팀에서 사용하는 대기콜 API
	CALL FN_CMM_Split_S(v_Dept_No, ',');
	
	DROP TEMPORARY TABLE IF EXISTS FN_CMM_Grant_S;
	CREATE TEMPORARY TABLE IF NOT EXISTS FN_CMM_Grant_S
	( 
		`VALUE` VARCHAR(50) 
	);

	INSERT INTO FN_CMM_Grant_S
	SELECT Que_Code FROM ims.code_dept_que WHERE Dept_No IN(SELECT `value` FROM FN_CMM_Split_S);

	SELECT WaitCalls
	, Received
	, Answered
	, Abandoned
	FROM
		(
		SELECT DATE_FORMAT(`date`,'%Y-%m-%d') AS DT
			, (SELECT IFNULL(SUM(Contacts), 0) AS WaitCalls FROM Mntng_QueueRealTime WHERE QueueKey IN(SELECT * FROM FN_CMM_Grant_S)) AS WaitCalls
			, IFNULL(SUM(Received), 0) AS Received
			, IFNULL(SUM(Answered), 0) AS Answered
			, IFNULL(SUM(Abandoned), 0) AS Abandoned
			, IFNULL(CAST(RIGHT(DATE_FORMAT(`date`,'%Y-%m-%d %H'),2) AS SIGNED INTEGER), 0) AS  TimeUnit
		FROM Mntng_QueueCumulative 
		WHERE QueueKey IN(SELECT `VALUE` FROM FN_CMM_Grant_S)
		AND `date` >= DATE_FORMAT(CURRENT_TIMESTAMP,'%Y-%m-%d')
		GROUP BY DATE_FORMAT(`date`,'%Y-%m-%d') 
	) X 
	WHERE TimeUnit >= 9 AND TimeUnit <= 20;
	
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `USP_Mnt_Mntng_CallBack_DomainNum_No_Session_S` */

/*!50003 DROP PROCEDURE IF EXISTS  `USP_Mnt_Mntng_CallBack_DomainNum_No_Session_S` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`ims`@`%` PROCEDURE `USP_Mnt_Mntng_CallBack_DomainNum_No_Session_S`(
v_Dept_No VARCHAR(4000)
)
BEGIN
	-- 유비케어 부서코드를 선택할경우 선택된 부서의 큐를 조회
	-- 콜관련 API (약국서비스팀)

	CALL FN_CMM_Split_S(v_Dept_No, ',');
		
	DROP TEMPORARY TABLE IF EXISTS FN_CMM_Grant_S;
	CREATE TEMPORARY TABLE IF NOT EXISTS FN_CMM_Grant_S
	( 
		`VALUE` VARCHAR(50) 
	);

	INSERT INTO FN_CMM_Grant_S
	SELECT Que_Code FROM ims.code_dept_que WHERE Dept_No IN(SELECT `value` FROM FN_CMM_Split_S);

	
	SELECT DISTINCT(Que_Div) AS domain_num
	FROM code_queue
	WHERE Que_Code IN(SELECT `VALUE` FROM FN_CMM_Grant_S);
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
