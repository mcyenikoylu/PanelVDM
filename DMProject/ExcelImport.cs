using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.OleDb;

namespace DMProject
{
    public class ExcelImport
    {
        public static DataSet ToDataSet(string FullPathWithFileName, bool IlkSatiriBaslikOlarakKullan)
        {
            string HDR = IlkSatiriBaslikOlarakKullan ? "HDR=YES;" : "HDR=NO;";
            string strConn;
            //if (FullPathWithFileName.Substring(FullPathWithFileName.LastIndexOf('.')).ToLower() == ".xlsx")
                strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FullPathWithFileName + ";Extended Properties=\"Excel 12.0;" + HDR + "IMEX=1\"";
            //else
                //strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FullPathWithFileName + ";Extended Properties=\"Excel 8.0;" + HDR + "IMEX=1\"";

            DataSet output = new DataSet();

            using (OleDbConnection conn = new OleDbConnection(strConn))
            {
                conn.Open();

                DataTable schemaTable = conn.GetOleDbSchemaTable(
                    OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

                foreach (DataRow schemaRow in schemaTable.Rows)
                {
                    string sheet = schemaRow["TABLE_NAME"].ToString();

                    if (!sheet.EndsWith("_"))
                    {
                        try
                        {
                            OleDbCommand cmd = new OleDbCommand("SELECT * FROM [" + sheet + "]", conn);
                            cmd.CommandType = CommandType.Text;

                            DataTable outputTable = new DataTable(sheet);

                            output.Tables.Add(outputTable);
                            new OleDbDataAdapter(cmd).Fill(outputTable);
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(ex.Message + string.Format("Sheet:{0}.File:F{1}", sheet, FullPathWithFileName), ex);
                        }
                    }
                }
            }
            return output;
        }

    }
}
