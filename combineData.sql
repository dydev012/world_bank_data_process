-- Combined Table VIEW
Drop view if exists CombinedView
GO
	CREATE VIEW CombinedView AS --split grants and credits into a CTE
	WITH CreditsExpr AS (
		SELECT
			loan_number,
			original_principal_amount,
			country,
			project_name,
			borrowers_obligation,
			Agreement_Signing_Date,
			project_id,
			disbursed_amount,
			undisbursed_amount,
			cancelled_amount
		FROM
			WorldBank.dbo.Credits
	) (
		SELECT
			country,
			loan_number,
			original_principal_amount,
			project_name,
			project_id,
			CASE
				WHEN loan_number LIKE 'IDAH%' THEN 'Grant'
				WHEN loan_number LIKE 'IBRD%' THEN 'Loan'
				ELSE 'Credit'
			END AS loan_type,
			CASE
				WHEN loan_number LIKE 'IDAH%' THEN original_principal_amount
				ELSE 0
			END AS grant_principal,
			CASE
				WHEN loan_number LIKE 'IBRD%' THEN original_principal_amount
				ELSE 0
			END AS loan_principal,
			CASE
				WHEN loan_number LIKE 'IBRD%' THEN 0
				WHEN loan_number LIKE 'IDAH%' THEN 0
				ELSE original_principal_amount
			END AS credit_principal,
			CASE
				WHEN borrowers_obligation <= 1 THEN 0
				ELSE borrowers_obligation
			END AS borrowers_obligation,
			agreement_signing_date,
			CASE
				WHEN disbursed_amount <= 1 THEN 0
				ELSE disbursed_amount
			END AS disbursed_amount,
			CASE
				WHEN undisbursed_amount <= 1 THEN 0
				ELSE undisbursed_amount
			END AS undisbursed_amount,
			CASE
				WHEN cancelled_amount <= 1 THEN 0
				ELSE cancelled_amount
			END AS cancelled_amount
		FROM
			(
				SELECT
					*
				FROM
					CreditsExpr
				UNION
				SELECT
					loan_number,
					original_principal_amount,
					country,
					project_name,
					borrowers_obligation,
					agreement_signing_date,
					project_id,
					disbursed_amount,
					undisbursed_amount,
					cancelled_amount
				FROM
					WorldBank.dbo.Loans
			) t
	);

GO
	---- END@! RUN2