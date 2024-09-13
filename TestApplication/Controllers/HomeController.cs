using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using TestApplication.Models;

namespace TestApplication.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public IConfiguration config;

        public HomeController(ILogger<HomeController> logger, IConfiguration configuration)
        {
            _logger = logger;
            config = configuration;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Product()
        {
            return View();
        }

        public IActionResult Order()
        {
            return View();
        }

        public IActionResult OrderList()
        {
            return View();
        }

        public ActionResult GetDropDown()
        {
            string val = Request.Query["q"];
            string id = Request.Query["id"];
            string text = Request.Query["text"];
            string table = Request.Query["table"];
            string condition = Request.Query["condition"];
            string coldata = String.IsNullOrEmpty(Request.Query["ColData"]) ? "" : Request.Query["ColData"];
            ArrayList results = new ArrayList();
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmdSql = conn.CreateCommand())
                    {
                        try
                        {
                            cmdSql.CommandType = CommandType.Text;
                            cmdSql.CommandText = " SELECT " + id + " AS id," + text + " AS text " + coldata +
                                                      " FROM " + table +
                                                      " WHERE (" + id + " like '%" + val + "%' OR " + text + " like '%" + val + "%') AND IsActive = 1" + condition +
                                                     " ORDER BY " + text +";";
                            using (SqlDataReader sdr = cmdSql.ExecuteReader())
                            {
                                while (sdr.Read())
                                {
                                    if (coldata != "" && coldata != null)
                                        results.Add(new { id = sdr["id"].ToString().Trim(), text = sdr["text"].ToString().Trim(), ColData = sdr["ColData"].ToString().Trim() });
                                    else
                                        results.Add(new { id = sdr["id"].ToString().Trim(), text = sdr["text"].ToString().Trim() });
                                }
                            }
                        }
                        catch (Exception err)
                        {
                            throw new InvalidOperationException(err.Message);
                        }
                        finally
                        { 
                            conn.Close();
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, msg = e.Message.ToString() });
            }
            return Json(new { results });
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
