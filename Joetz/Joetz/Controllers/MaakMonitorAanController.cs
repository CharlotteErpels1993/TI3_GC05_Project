﻿
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System;
using System.Configuration;
using Joetz.Models;
using Microsoft.Office.Interop.Excel;

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

        //private OpenFileDialog openFileDialog1;
        /*private File

         * vindt openfiledialog niet => andere oplossing of missende extensie?

        private void btnUpload_Click(object sender, EventArgs e, MaakMonitorenAanModel model)
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
    /*    }



        /*protected void btnUpload_Click(object sender, EventArgs e, MaakMonitorenAanModel model)
        {
            
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();

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

            string fileName = 
            string connectionString = String.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;" +
                                      "Data Source={0};Extended Properties='Excel 12.0;HDR=YES;IMEX=0'", fileName);
            using (OleDbConnection cn = new OleDbConnection(connectionString))
            {
                cn.Open();
                OleDbCommand cmd = new OleDbCommand("SELECT Column1, Column2, Column3 From [Sheet1$]", cn);
                OleDbDataReader rd = cmd.ExecuteReader();
                while (rd.Read())
                {
                    Console.WriteLine("Loop");
                    Console.WriteLine(rd.GetString(0));
                    Console.WriteLine(rd.GetString(1));
                    Console.WriteLine(rd.GetString(2));
                    Console.WriteLine();
                }
            }
        }*/
   }
}
