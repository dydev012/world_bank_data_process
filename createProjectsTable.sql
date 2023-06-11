Drop view if exists Projects
GO
	CREATE VIEW Projects AS --Order by Largest Single Projects, with countries and signing information
	WITH ProjectsPrep AS (
		SELECT
			project_id,
			STRING_AGG(project_name, '#') AS project_name,
			country,
			MIN(agreement_signing_date) As initial_funding_date,
			SUM(original_principal_amount) AS original_principal_amount,
			SUM(borrowers_obligation) AS borrowers_obligation,
			SUM(disbursed_amount) AS disbursed_amount,
			SUM(undisbursed_amount) AS undisbursed_amount,
			SUM(cancelled_amount) AS cancelled_amount
		FROM
			CombinedView
		Group By
			project_id,
			country
		Order By
			original_principal_amount DESC OFFSET 0 ROWS
	) (
		--Convert # Seperated values to the first occurance
		SELECT
			project_id,
			CASE
				WHEN CHARINDEX('#', project_name) = 0 THEN project_name
				WHEN CHARINDEX('#', project_name) != 0 THEN SUBSTRING(project_name, 0, CHARINDEX('#', project_name))
			END AS project_name,
			country,
			initial_funding_date,
			original_principal_amount,
			borrowers_obligation,
			disbursed_amount,
			undisbursed_amount,
			cancelled_amount
		FROM
			ProjectsPrep
	);

GO