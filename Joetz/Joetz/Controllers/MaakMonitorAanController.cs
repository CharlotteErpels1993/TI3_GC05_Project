
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Net.Http;
using Joetz.Models;
using System.Windows;
//using Microsoft.Office.Interop.Excel;
using Parse;
using Microsoft.Win32;
using Microsoft.VisualBasic;
using Gat.Controls;
using Joetz.Models.Domain;

namespace Joetz.Controllers
{
    public class MaakMonitorAanController : Controller
    {
        //
        // GET: /MaakMonitorAan/

        public ActionResult Index()
        {
            if (Parse.ParseUser.CurrentUser != null)
            {
                return View();
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        [HttpPost]
        public ActionResult Index(HttpPostedFileBase file_uploader)
        {

            string fileName;
            string destinationPath;

            if (file_uploader != null)
            {
                fileName = string.Empty;
                destinationPath = string.Empty;

                List<Joetz.Models.Domain.FileUploadModel> uploadFileModel = new List<FileUploadModel>();

                fileName = Path.GetFileName(file_uploader.FileName);
                destinationPath = Path.Combine(Server.MapPath("~/"), fileName);
                file_uploader.SaveAs(destinationPath);
                uploadFileModel.Add(new FileUploadModel { FileName = fileName, FilePath = destinationPath });
                Session["fileUploader"] = uploadFileModel;

                //FileResult fileResult = File(new FileStream(Server.MapPath("~/MyFiles/" + fileName), FileMode.Open), "application/octetstream", fileName);

                string connectionString = String.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;" +
                                      "Data Source={0};Extended Properties='Excel 12.0;HDR=YES;IMEX=0'", fileName);
            
                using (OleDbConnection cn = new OleDbConnection(connectionString))
                {
                    cn.Open();
                    OleDbCommand cmd = new OleDbCommand("SELECT * From [Sheet1$]", cn);
                    OleDbDataReader rd = cmd.ExecuteReader();

                    int tellerEersteRij = 0;

                    while (rd.Read())
                    {
                        
                        Console.WriteLine("in loop");
               /*
                    Console.WriteLine("Loop");
                    Console.WriteLine(rd.GetString(0));
                    Console.WriteLine(rd.GetString(1));
                    Console.WriteLine(rd.GetString(2));
                    Console.WriteLine();*/

                        var monitor = new ParseObject("Monitor");
                        monitor["email"] = rd.GetString(1);
                        monitor["rijksregisterNr"] = rd.GetString(2);
                        monitor["voornaam"] = rd.GetString(3);
                        monitor["naam"] = rd.GetString(4);
                        monitor["straat"] = rd.GetString(5);
                        monitor["nummer"] = rd.GetInt32(6);
                        //monitor["bus"] = rd.GetString(7);
                        monitor["postcode"] = rd.GetInt32(8);
                        monitor["gemeente"] = rd.GetString(9);
                        monitor["gsm"] = rd.GetString(10);
                        //monitor["telefoon"] = rd.GetString(11);
                        //monitor["aansluitingsNr"] = rd.GetInt32(12);
                        //monitor["codeGerechtigde"] = rd.GetInt32(13);
                        monitor["lidnummer"] = rd.GetString(10);
                    
                        monitor.SaveAsync();
                    }
                    Console.WriteLine("uit while");
                }
            }




            return View();

        }


        //
        // GET: /MaakMonitorAan/Details/5

        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /MaakMonitorAan/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /MaakMonitorAan/Create

        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /MaakMonitorAan/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /MaakMonitorAan/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /MaakMonitorAan/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /MaakMonitorAan/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        [HttpPost]
        public void UploadFile(Object sender, EventArgs e)
        {
            HttpResponseMessage result = null;
            var httpRequest = HttpContext.Request;
            
            

            if (httpRequest.Files.Count > 0)
            {
                var files = new List<string>();

                foreach (string file in httpRequest.Files)
                {
                    var postedFile = httpRequest.Files[file];
                    /*var filePath = HttpContext.Server.MapPath("~/" + postedFile.FileName);
                    postedFile.SaveAs(filePath);*/
                    readExcelFile(postedFile);

                }
            }
        }

        private void readExcelFile(HttpPostedFileBase file)
        {
            string conStr = "";

            string fileName = Path.GetFileName(file.FileName);
            string extension = Path.GetExtension(file.FileName);
            string folderPath = ConfigurationManager.AppSettings["folderPath"];
            string filePath = Server.MapPath(folderPath + fileName);
            string hasHeader = "yes";

            switch (extension)
            {
                case ".xls": //Excel 97-03
                    conStr = ConfigurationManager.ConnectionStrings["xls"].ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    conStr = ConfigurationManager.ConnectionStrings["xlsx"].ConnectionString;
                    break;
            }

            conStr = String.Format(conStr, filePath, hasHeader);
            
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            DataTable dt = new DataTable();

            cmdExcel.Connection = connExcel;

            //Get the name of First Sheet
            connExcel.Open();

            System.Type typeString = System.Type.GetType("System.String");
            System.Type typeInt = System.Type.GetType("System.Int32");

            string[] columnNames = new string[14]
            {
                "email", 
                "rijksregisterNr", 
                "voornaam", 
                "achternaam",
                "straat",
                "nummer",
                "bus",
                "postcode",
                "gemeente",
                "gsm",
                "telefoon",
                "aansluitingsNr",
                "codeGerechtigde",
                "lidNr"
            };



            System.Type[] columnTypes = new System.Type[14]
            {
                typeString, 
                typeString, 
                typeString, 
                typeString,
                typeString,
                typeInt,
                typeString,
                typeInt,
                typeString,
                typeString,
                typeString,
                typeInt,
                typeInt,
                typeString
            };

            for (int i = 0; i < 14; i++)
            {
                dt.Columns.Add(columnNames[i], columnTypes[i]);
            }

            DataTable dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();

            connExcel.Close();

            //Read Data from First Sheet
            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From [" + SheetName + "]";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();

            var monitors = new List<ParseObject>();

            ParseObject monitor = new ParseObject("Monitor");

            foreach (DataRow row in dt.Rows)
            {
                monitor["email"] = row["email"] as string;
                monitor["rijksregisterNr"] = row["rijksregisterNr"] as string;
                monitor["voornaam"] = row["voornaam"] as string;
                monitor["naam"] = row["achternaam"] as string;
                monitor["nummer"] = row["nummer"];
                monitor["postcode"] = row["postcode"];
                monitor["gemeente"] = row["gemeente"] as string;
                monitor["gsm"] = row["gsm"] as string;
                monitor["aansluitingsNr"] = row["aansluitingsNr"];
                monitor["codeGerechtigde"] = row["codeGerechtigde"];
                monitor["lidNr"] = row["lidNr"] as string;

                if (row["bus"] == null)
                {
                    monitor["bus"] = "";
                }
                else
                {
                    monitor["bus"] = row["bus"] as string;
                }

                if (row["telefoon"] == null)
                {
                    monitor["telefoon"] = "";
                }
                else
                {
                    monitor["telefoon"] = row["telefoon"] as string;
                }
                monitor.SaveAsync();
            }

            //Bind Data to GridView
            //GridView1.Caption = Path.GetFileName(FilePath);
            //GridView1.DataSource = dt;
            //GridView1.DataBind();
        }

        /*public void OpenFileDialog(object sender, EventArgs ea)
        {
            //Initializing Open Dialog
            OpenDialogView openDialog = new OpenDialogView();
            OpenDialogViewModel vm = (OpenDialogViewModel) openDialog.DataContext;
            
            //Adding file filter
            vm.AddFileFilterExtension(".xls");

            string filePath = "";

            //Show dialog and take result into account
            bool? result = vm.Show();
            if (result == true)
            {
                //Get selected file path
                filePath = vm.SelectedFilePath;
            }
            else
            {
                filePath = string.Empty;
            }

            //Setting the Date format by using predefined date format
            vm.DateFormat = OpenDialogViewModel.ISO8601_DateFormat;

            //Setting folder dialog
            vm.IsDirectoryChooser = true;
            vm.Show();

            //Setting save dialog
            vm.IsDirectoryChooser = false;
            vm.IsSaveDialog = true;

            //Customize UI Texts
            vm.CancelText = "Annuleer";
            vm.Caption = "Caption";
            vm.DateFormat = "yy_MM_dd HH:mm:ss";
            vm.DateText = "DateTime";
            vm.FileFilterText = "File extension";
            vm.FileNameText = "File path";
            vm.NameText = "File";
            vm.SaveText = "Store";
            vm.SizeText = "Length";
            vm.TypeText = "File Type";

            //Setting window properties
            
            //Show
            vm.Show();

        }*/


        //private OpenFileDialog openFileDialog1;
        /*private File

         /* vindt openfiledialog niet => andere oplossing of missende extensie?*/

       /* private void btnUpload_Click(object sender, EventArgs e, MaakMonitorenAanModel model)
        {
           

           /* OpenFileDialog openFileDialog1 = new OpenFileDialog();
            
            openFileDialog1.InitialDirectory = @"C:\";
            openFileDialog1.Title = "Browse Text Files";

            openFileDialog1.CheckFileExists = true;
            openFileDialog1.CheckPathExists = true;

            openFileDialog1.DefaultExt = "txt";
            openFileDialog1.Filter = "Text files (*.txt)|*.txt|All files (*.*)|*.*";
            openFileDialog1.FilterIndex = 2;
            openFileDialog1.RestoreDirectory = true;

            openFileDialog1.ReadOnlyChecked = true;
            openFileDialog1.ShowReadOnly = true;

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                model.fileNaam = openFileDialog1.FileName;
            }*/
       //}




        protected async void btnUpload_Click(object sender, EventArgs e)
        {
            
            //this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();

           /* Microsoft.Office.Core.FileDialog fd =
            this.Application.get_FileDialog(Microsoft.Office.Core.MsoFileDialogType.msoFileDialogOpen);

            fd.AllowMultiSelect = true;
            fd.Filters.Clear();
            fd.Filters.Add("Excel Files", "*.xls;*.xlw");
            fd.Filters.Add("All Files", "*.*");

            if (fd.Show() != 0)
            {
                fd.Execute();
            }*/
         /*   OpenFileDialog browsedFile = new OpenFileDialog();
            browsedFile.Filter = "XML Files (*.xml,*.xls,*.xlsx,*.xlsm,*.xlsb)"+
                "|*.xml*.xls,*.xlsx,*.xlsm,*.xlsb|All files (*.*)|*.*";
            browsedFile.ShowDialog();
          * 
          *  var jobApplication = new ParseObject("Monitor");
            jobApplication["aansluitingsNr"] = "";
            jobApplication["applicantResumeFile"] = file;
            await jobApplication.SaveAsync();
        */
            string fileName = @"C:\test.xlsx";
            string connectionString = String.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;" +
                                      "Data Source={0};Extended Properties='Excel 12.0;HDR=YES;IMEX=0'", fileName);
            using (OleDbConnection cn = new OleDbConnection(connectionString))
            {
                cn.Open();
                OleDbCommand cmd = new OleDbCommand("SELECT * From [Sheet1$]", cn);
                OleDbDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Console.WriteLine("in loop");
               /*
                    Console.WriteLine("Loop");
                    Console.WriteLine(rd.GetString(0));
                    Console.WriteLine(rd.GetString(1));
                    Console.WriteLine(rd.GetString(2));
                    Console.WriteLine();*/
                    var monitor = new ParseObject("Monitor");
                    monitor["aansluitingsNr"] = rd.GetString(0);
                    monitor["codeGerechtigde"] = rd.GetString(2);

                    monitor["email"] = rd.GetString(3);
                    monitor["gemeente"] = rd.GetString(4);
                    monitor["gsm"] = rd.GetString(5);
                    monitor["lidnummer"] = rd.GetString(7);

                    monitor["linkFacebook"] = rd.GetString(8);
                    monitor["naam"] = rd.GetString(9);
                    monitor["nummer"] = rd.GetString(10);
                    monitor["postcode"] = rd.GetString(11);
                    monitor["rijksregisterNr"] = rd.GetString(12);
                    monitor["straat"] = rd.GetString(13);
                    monitor["voornaam"] = rd.GetString(15);
                    await monitor.SaveAsync();
                }
                Console.WriteLine("uit while");

                //evt hardcoded waarden sturen en zeggen dat het op diie manier excel zou moeten uploaden en dan monitor aanmaakt op basis van die gegevens
            }
        }
   }
}
