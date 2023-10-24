using System.Data;
using System.Configuration;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Reflection.Metadata.Ecma335;


namespace RegistrationPage1.Models
{
    public class RegDAL
    {


        public SqlConnection con = new SqlConnection("Data Source=192.168.25.25; Initial Catalog=ENFINLiveTestDB; Persist Security Info=True;User ID=Dev_Test_CH;Password=RT78^yykh987");

        public List<Reg> GetDataList()
        {
            List<Reg> lst = new List<Reg>();

            SqlCommand cmd = new SqlCommand("sp_MVC1", con);

            cmd.CommandType = CommandType.StoredProcedure;


            DataTable dt = new DataTable();



            SqlDataAdapter adp = new SqlDataAdapter(cmd);

            adp.Fill(dt);



            Reg r = new Reg();

            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new Reg());

                r.Firstname = Convert.ToString(dr["strfirst_name"]);
                r.Lastname = Convert.ToString(dr["strlast_name"]);
                r.Dateofbirth = dr["dtedob"].ToString();
                r.Hobbies = Convert.ToString(dr["strhobbies"]);
                r.Gender = Convert.ToString(dr["strgender"]);
                r.State = Convert.ToString(dr["strstate"]);
                r.City = Convert.ToString(dr["strcity"]);
                r.UploadImage = Convert.ToString(dr["uploadimage"]);
                r.UploadPdf = Convert.ToString(dr["uploadpdf"]);

                lst.Add(r);



            }


            return lst;

        }


        












    }
}


