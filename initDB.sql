/* Dataset Source
IBRD LOANS: https://finances.worldbank.org/Loans-and-Credits/IBRD-Statement-of-Loans-Latest-Available-Snapshot/sfv5-tf7p
IDA Credits & Grants: https://finances.worldbank.org/Loans-and-Credits/IDA-Statement-of-Credits-and-Grants-Latest-Availab/ebmi-69yj
*/

-- Queries Valid for Apr 2023 Data
SELECT *
FROM WorldBank.dbo.Loans;

-- CORRECTING DTYPES --
-- tsql does not have a mm/dd/yyyy hh:mm:ssAM format,
-- so all the datetimes were imported as strings.
-- We can convert to dates and this is good enough.

-- @!RUN 1
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN end_of_period Date;
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN first_repayment_date Date;
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN last_repayment_date Date;
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN agreement_signing_date Date;
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN board_approval_date Date;
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN effective_date_most_recent Date;
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN closed_date_most_recent Date;
ALTER TABLE WorldBank.dbo.Loans ALTER COLUMN last_disbursement_date Date;

ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN end_of_period Date;
ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN first_repayment_date Date;
ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN last_repayment_date Date;
ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN agreement_signing_date Date;
ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN board_approval_date Date;
ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN effective_date_most_recent Date;
ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN closed_date_most_recent Date;
ALTER TABLE WorldBank.dbo.Credits ALTER COLUMN last_disbursement_date Date;
-- END@!RUN 1

--loan_numbers - Loans start with IBRD,
--				Grants with IDAH
--				Credits with IDA

--8,991				
SELECT *
FROM WorldBank.dbo.Loans;

--10,106
SELECT *
FROM WorldBank.dbo.Credits;
-- total: 19,097


-- @RUN 2
--rename columns so both tables match
EXEC sp_rename 'dbo.Credits.credit_number', 'loan_number', 'COLUMN';
EXEC sp_rename 'dbo.Credits.original_principal_amount_us', 'original_principal_amount', 'COLUMN';
EXEC sp_rename 'dbo.Credits.cancelled_amount_us', 'cancelled_amount', 'COLUMN';
EXEC sp_rename 'dbo.Credits.undisbursed_amount_us', 'undisbursed_amount', 'COLUMN';
EXEC sp_rename 'dbo.Credits.disbursed_amount_us', 'disbursed_amount', 'COLUMN';
EXEC sp_rename 'dbo.Credits.repaid_to_IDA_US', 'repaid_to_IDA', 'COLUMN';

EXEC sp_rename 'dbo.Credits.borrower_s_obligation_us', 'borrowers_obligation', 'COLUMN';
EXEC sp_rename 'dbo.Loans.borrower_s_obligation', 'borrowers_obligation', 'COLUMN';
---- END@! RUN2