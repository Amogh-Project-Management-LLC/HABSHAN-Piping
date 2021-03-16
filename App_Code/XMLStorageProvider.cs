using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Web.UI;
using Telerik.Web.UI.PersistenceFramework;
using System.IO;
using System.IO.Compression;
using System.Text;
using System.Data.OracleClient;
using System.Data;

/// <summary>
/// Summary description for CookieStorageProvider
/// </summary>
public class XMLStorageProvider : IStateStorageProvider
{
    public void SaveStateToStorage(string key, string serializedState)
    {

        OracleConnection connection = WebTools.GetIpmsConnection();
        byte[] byteArray = null;
        byteArray = Encoding.ASCII.GetBytes(serializedState);
        string query = "UPDATE CUSTOM_REPORT_INDEX SET REPORT_QUERY=:REPORT_QUERY";

        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            using (OracleCommand cmd = new OracleCommand(query, connection))
            {
                
                cmd.Parameters.Add("REPORT_QUERY", OracleType.Blob);
                cmd.Parameters[0].Value = byteArray;
                cmd.ExecuteNonQuery();
            }

        }
    }
    public string LoadStateFromStorage(string key)
    {
        StringBuilder sb = new StringBuilder();
        string query = "";
        string sql = "SELECT * FROM CUSTOM_REPORT_INDEX";

        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        if (dataReader["REPORT_QUERY"] != DBNull.Value)
                        {
                            byte[] byteArray = (Byte[])dataReader["REPORT_QUERY"];
                            query = Encoding.ASCII.GetString(byteArray);
                        }
                    }
                }
            }
        }
        return query;
    }
}
