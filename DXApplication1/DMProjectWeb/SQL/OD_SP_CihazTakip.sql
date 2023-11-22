-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE OD_SP_CihazTakip
	-- Add the parameters for the stored procedure here
	@AramaKelimesi nvarchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		cast(0 as decimal(12,2)) as FATURA_NET_TUTARI,
		'' as FATURA_NO,
		GETDATE() as FATURA_TAR,
		'' as FIRMA_ISMI,
		'' as IMEI,
		'' as STOK_ACIKLAMASI,
		'' as STOK_KODU

END
GO
