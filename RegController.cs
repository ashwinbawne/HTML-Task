using Microsoft.AspNetCore.Mvc;
using RegistrationPage1.Models;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mime;
using Microsoft.AspNetCore.Hosting;
using Grpc.Core;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;


namespace RegistrationPage1.Controllers
{

    public class RegController : Controller
    {

        private readonly IWebHostEnvironment _webhostenvironment;
        public RegController(IWebHostEnvironment webhostenvironment)
        {

            _webhostenvironment = webhostenvironment;
        }

        string str = "Data Source=192.168.25.25;Initial Catalog = ENFINLiveTestDB; Persist Security Info=True;User ID = Dev_Test_CH; Password=RT78^yykh987";

        RegDAL r = new RegDAL();
        public IActionResult Index()
        {

            RegDAL r = new RegDAL();
            List<Reg> lst = r.GetDataList();
            return View(lst);

        }





        public IActionResult Create()
        {
            List<Reg> lst = new List<Reg>();

            //List<SelectListItem> states = GetState();
            //ViewBag.States = states;



            //var data = GetState();
            //var data1 = GetCitiess();
            ViewBag.Hobbies = new List<string>
            {
                "Travelling",
                 "Cooking",
                 "Reading",
                 "Playing",
                 "Netsurfing",
            };




            ViewBag.SelectedHobbies = new List<string>
            {
                "Travelling",
                 "Cooking",
                 "Reading",
                 "Playing",
                 "Netsurfing",
            };


           

            return View();
        }



        

        public IActionResult Create(Reg r)
        {


            if (Duplicate(r))
            {
                if (r.FormImageFile != null && r.FormPdfFile != null)
                {
                    ImageFileToLocalDirectory(r);

                    PdfFileToLocalDirectory(r);
                    //DateTime now = DateTime.Now;
                    //long ticks = now.Ticks;
                    //string formattedDateTime = now.ToString("yyyy-MM-dd HH:mm:ss");


                    r.UploadImage = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + Path.GetExtension(r.FormImageFile.FileName);
                    r.UploadPdf = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + Path.GetExtension(r.FormPdfFile.FileName);
                }

                else
                {





                    //DateTime now = DateTime.Now;
                    //long ticks = now.Ticks;
                    //string formattedDateTime = now.ToString("yyyy-MM-dd HH:mm:ss");


                    r.UploadImage = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + ".jpg";
                    r.UploadPdf = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + ".pdf";

                }




                try
                {

                    using SqlConnection con = new SqlConnection(str);
                    con.Open();



                    SqlCommand cmd = new SqlCommand("sp_MVC1", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@operation", "Insert");
                    cmd.Parameters.AddWithValue("@First_name", r.Firstname);
                    cmd.Parameters.AddWithValue("@Last_name", r.Lastname);
                    cmd.Parameters.AddWithValue("@Date_of_birth", r.Dateofbirth);
                    cmd.Parameters.AddWithValue("@Hobbies", string.Join(",", r.Hobbie));
                    cmd.Parameters.AddWithValue("@Gender", r.Gender);
                    cmd.Parameters.AddWithValue("@States", r.State);
                    cmd.Parameters.AddWithValue("@City", r.City);
                    cmd.Parameters.AddWithValue("@UploadImage", r.UploadImage);
                    cmd.Parameters.AddWithValue("@UploadPdf", r.UploadPdf);


                    int i = cmd.ExecuteNonQuery();

                    con.Close();





                    return RedirectToAction("Details");

                }
                catch
                {
                    ViewBag.Hobbies = new List<string>
                    {
                       "Travelling",
                        "Cooking",
                        "Reading",
                       "Playing",
                       "Netsurfing",
                    };

                    return View();

                }

            }

            else
            {

                TempData["Message"] = "Employee already exist";
                return View();
            }




        }










        public ActionResult Details(int CurrentPage = 1, int RecordsPerPage = 3, string searchData = "")
        {

            List<Reg> r = new List<Reg>();
            using SqlConnection con = new SqlConnection(str);
            {

                SqlCommand cmd = new SqlCommand("GetPagedData", con);


                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PageNumber", CurrentPage);
                cmd.Parameters.AddWithValue("@PageSize", RecordsPerPage);
                cmd.Parameters.AddWithValue("@searchData", searchData);


                con.Open();


                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Reg reg = new Reg()
                    {
                        SerialNo = (long)reader["RowNum"],
                        Id = (Int32)reader["intid"],
                        Firstname = reader.GetString("strfirst_name"),
                        Lastname = reader.GetString("strlast_name"),
                        Dateofbirth = reader.GetString("dtedob"),

                        Hobbies = reader.GetString("strhobbies"),
                        Gender = reader.GetString("strgender"),
                        State = reader.GetString("strstates"),
                        City = reader.GetString("strcity"),
                        UploadImage = reader.GetString("uploadimage"),
                        UploadPdf = reader.GetString("uploadpdf"),


                    };


                    r.Add(reg);


                }
                con.Close();


                PagingData p = new PagingData();

                p.Data = r;


                p.RecordsPerPage = RecordsPerPage;
                p.CurrentPage = CurrentPage;
                p.SearchTerm = searchData;

                p.TotalRecords = GetAllUser(p.SearchTerm);



                return View(p);




            }

        }














        public ActionResult TotalRecords()
        {
            List<Reg> records = new List<Reg>();

            return View(records);
        }










        public IActionResult Edit(int id)
        {
            using (SqlConnection con = new SqlConnection(str))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("sp_MVC1", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@operation", "GetById");
                cmd.Parameters.AddWithValue("@Id", id);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    Reg reg = new Reg()
                    {
                        Id = reader.GetInt32("intid"),
                        Firstname = reader.GetString("strfirst_name"),
                        Lastname = reader.GetString("strlast_name"),
                        Dateofbirth = reader.GetString("dtedob"),
                        Hobbies = reader.GetString("strhobbies"),
                        Gender = reader.GetString("strgender"),
                        State = reader.GetString("strstates"),
                        City = reader.GetString("strcity"),
                        UploadImage = reader.GetString("uploadimage"),
                        UploadPdf = reader.GetString("uploadpdf"),
                    };


                    ViewBag.Hobbies = new List<string>
                    {
                      "Travelling",
                       "Cooking",
                       "Reading",
                       "Playing",
                      "Netsurfing",
                    };


                    ViewBag.SelectedHobbies = reg.Hobbies.Split(',').Select(h => h.Trim()).ToList();

                    return View(reg);
                }
            }

            return null;
        }





        [HttpPost]

        
        public IActionResult Edit(Reg r)
        {






            if (r.FormImageFile != null && r.FormPdfFile != null)
            {
                ImageFileToLocalDirectory(r);

                PdfFileToLocalDirectory(r);
                DateTime now = DateTime.Now;
                long ticks = now.Ticks;
                string formattedDateTime = now.ToString("yyyy-MM-dd HH:mm:ss");


                r.UploadImage = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + Path.GetExtension(r.FormImageFile.FileName);
                r.UploadPdf = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + Path.GetExtension(r.FormPdfFile.FileName);
            }

            else
            {





                DateTime now = DateTime.Now;
                long ticks = now.Ticks;
                string formattedDateTime = now.ToString("yyyy-MM-dd HH:mm:ss");


                r.UploadImage = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + ".jpg";
                r.UploadPdf = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth + ".pdf";
            }




            try
            {

                using SqlConnection con = new SqlConnection(str);
                {
                    con.Open();


                    SqlCommand cmd = new SqlCommand("sp_MVC1", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@operation", "Update");
                    cmd.Parameters.AddWithValue("@Id", r.Id);
                    cmd.Parameters.AddWithValue("@First_name", r.Firstname);
                    cmd.Parameters.AddWithValue("@Last_name", r.Lastname);
                    cmd.Parameters.AddWithValue("@Date_of_birth", r.Dateofbirth);
                    cmd.Parameters.AddWithValue("@Hobbies", string.Join(",", r.Hobbie));
                    cmd.Parameters.AddWithValue("@Gender", r.Gender);
                    cmd.Parameters.AddWithValue("@States", r.State);
                    cmd.Parameters.AddWithValue("@City", r.City);
                    cmd.Parameters.AddWithValue("@UploadImage", r.UploadImage);
                    cmd.Parameters.AddWithValue("@UploadPdf", r.UploadPdf);




                    cmd.ExecuteNonQuery();



                    con.Close();
                }

                return RedirectToAction("Details");


            }
            catch
            {

                ViewBag.Hobbies = new List<string>
                {
                  "Travelling",
                   "Cooking",
                   "Reading",
                  "Playing",
                  "Netsurfing",
                };

            
                return View();

            }




        }



        public IActionResult Delete(int id)
        {
            using SqlConnection con1 = new SqlConnection(str);
            
            SqlCommand cmd1 = new SqlCommand("sp_MVC1", con1);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@operation", "GetById");
            cmd1.Parameters.AddWithValue("@Id", id);

            con1.Open();


            SqlDataReader reader = cmd1.ExecuteReader();

            while (reader.Read())
            {
               
                   string ImageFile = reader["UploadImage"].ToString();
                   string PdfFile = reader["UploadPdf"].ToString();
                   DeleteFile(ImageFile);
                   DeleteFile(PdfFile);


            }

            try
            {
                using SqlConnection con = new SqlConnection(str);
                {
                    con.Open();




                    SqlCommand cmd = new SqlCommand("sp_MVC1", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@operation", "Delete");
                    cmd.Parameters.AddWithValue("@Id", id);



                    cmd.ExecuteNonQuery();



                    con.Close();

                    return RedirectToAction("Details");

                }
            }

               catch
              {
                return View();
               }
        
        }



        


       
        public bool ImageFileToLocalDirectory(Reg r)
        {
            if (r.FormImageFile != null && r.FormImageFile.Length > 0)
            {
                var fileExtension = Path.GetExtension(r.FormImageFile.FileName);
                var allowedExtensions = new[] { ".JPG", ".PNG" };
                if (!allowedExtensions.Contains(fileExtension))
                {
                    return false;
                }
        
                var fileName = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth;
                string filePath = Path.Combine(_webhostenvironment.WebRootPath, fileName + fileExtension);


                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    r.FormImageFile.CopyTo(stream);
                }
            }
            return true;
        }

        public bool PdfFileToLocalDirectory(Reg r)
        {

         
            if (r.FormPdfFile != null && r.FormPdfFile.Length > 0)
            {
                var fileExtension = Path.GetExtension(r.FormPdfFile.FileName);
                var allowedExtensions = new[] { ".pdf" };
                if (!allowedExtensions.Contains(fileExtension))
                {
                    return false;
                }
                //DateTime now = DateTime.Now;
                //long ticks = now.Ticks;
                //string formattedDateTime = now.ToString("yyyy-MM-dd HH:mm:ss"); 
                
                var fileName = r.Firstname + "_" + r.Lastname + "_" + r.Dateofbirth;
                string filePath = Path.Combine(_webhostenvironment.WebRootPath,  fileName + fileExtension);
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    r.FormPdfFile.CopyTo(stream);

                }
            }
            return true;
        }


       





        public IActionResult DownloadFile(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
            {
                return NotFound();
            }
            string filePath = Path.Combine(_webhostenvironment.WebRootPath, fileName);
            if (!System.IO.File.Exists(filePath))
            {       
                return NotFound();
            }

            var contentDisposition = new ContentDisposition
            {
                FileName = fileName,
                Inline = false,
            };
            Response.Headers.Add("Content-Disposition", contentDisposition.ToString());

            var fileStream = System.IO.File.OpenRead(filePath);
            return File(fileStream, "application/octet-stream");

        }



        public IActionResult GetImage(string fileName)
        {
            var imagePath = Path.Combine(_webhostenvironment.WebRootPath, fileName);

            if (System.IO.File.Exists(imagePath))
            {
                var imageBytes = System.IO.File.ReadAllBytes(imagePath);
                return File(imageBytes, "image/jpeg");
            }
            
            else
            {
                return NotFound();
            }
        }


        public IActionResult GetPdf(string fileName)
        {
            var pdfPath = Path.Combine(_webhostenvironment.WebRootPath, fileName);

            if (System.IO.File.Exists(pdfPath))
            {
                var pdfBytes = System.IO.File.ReadAllBytes(pdfPath);
                return File(pdfBytes, "application/pdf"); 
            }
            else
            {
                return NotFound();
            }
        }


        public bool Duplicate(Reg r)
        {
            using (SqlConnection con = new SqlConnection(str))
            {
                con.Open();


                SqlCommand cmd = new SqlCommand("sp_MVC1", con);
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@operation", "ValidateUser");
                    cmd.Parameters.AddWithValue("@First_name", r.Firstname);
                    cmd.Parameters.AddWithValue("@Last_name", r.Lastname);
                    cmd.Parameters.AddWithValue("@Date_of_birth", r.Dateofbirth);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {


                        return false;

                    }

                    return true;


                }
            
            
            }  
        }

        public void DeleteFile(string fileName)
        {
            var pdfPath = Path.Combine(_webhostenvironment.WebRootPath, fileName);
            if (System.IO.File.Exists(pdfPath))
            {
                System.IO.File.Delete(pdfPath);
            }
        }



        public int GetAllUser( string searchData = "")
        {
            int count = 0;

            using (SqlConnection con = new SqlConnection(str))
            {
                con.Open();


                SqlCommand cmd = new SqlCommand("sp_MVC1", con);
                {

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@operation", "GetAllUsers");
                    cmd.Parameters.AddWithValue("@searchData", searchData);
                    

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {


                         count++;

                    }

                    return count;


                }


            }

        }



        //public List<SelectListItem> GetState()
        //{
        //    List<State> stateList = new List<State>();
        //    try
        //    {
        //        using (SqlConnection con = new SqlConnection(str))
        //        {
        //            con.Open();
        //            using (SqlCommand cmd = new SqlCommand("sp_MVC1", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@operation", "GetAllStates");
                      

        //                using (SqlDataReader reader = cmd.ExecuteReader())
        //                {
        //                    while (reader.Read())
        //                    {
        //                        State state = new State
        //                        {
        //                            StateID= Convert.ToInt32(reader["StateId"]),
        //                            StateName = reader["StateName"].ToString()
        //                        };
        //                        stateList.Add(state);
        //                    }

        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine("Error: " + ex.Message);
        //    }


        //    List<SelectListItem> stateListItems = stateList.Select(state => new SelectListItem
        //    {
        //        Value = state.StateID.ToString(),
        //        Text = state.StateName.ToString(),
        //    }).ToList();
        //    return stateListItems;

        //}

        //public List<City> GetCitiess()
        //{
        //    List<City> cities = new List<City>();
        //    try
        //    {
        //        using (SqlConnection con = new SqlConnection(str))
        //        {
        //            con.Open();
        //            using (SqlCommand cmd = new SqlCommand("sp_MVC1", con))
        //            {
        //                cmd.CommandType = CommandType.StoredProcedure;
        //                cmd.Parameters.AddWithValue("@operation", "GetCitiesByState");
                 
        //                using (SqlDataReader reader = cmd.ExecuteReader())
        //                {
        //                    while (reader.Read())
        //                    {
        //                        City citi = new City
        //                        {
        //                            CityID = Convert.ToInt32(reader["CityId"]),
        //                            CityName = reader["CityName"].ToString(),
        //                            StateID = Convert.ToInt32(reader["StateId"])
        //                        };
        //                        cities.Add(citi);
        //                    }
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine("Error: " + ex.Message);
        //    }
        //    return cities;
        //}

        //public JsonResult GetCities(int StateId)
        //{
        //    var cities = GetCitiess().Where(city => city.StateID == StateId).Select(city => new { Value = city.CityID, Text = city.CityName }).ToList();
        //    return new JsonResult(cities);

        //}






































    }
}
