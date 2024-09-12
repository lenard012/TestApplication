using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using TestApplication.Models;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace TestApplication.Controllers
{
    public class CustomerController : Controller
    {
        public IConfiguration config;
        public CustomerController(IConfiguration configuration) {
            config = configuration;
        }
        public IActionResult Index()
        {
            return View();
        }

        public ActionResult GetCustomer() 
        {
            List<Customer> data = new List<Customer>();
            int totalrows = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "CustomerGet";

                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            while (sdr.Read()) {
                                data.Add(new Customer
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    FirstName = sdr["FirstName"].ToString(),
                                    LastName = sdr["LastName"].ToString(),
                                    FullName = sdr["FullName"].ToString(),
                                    MobileNumber = sdr["MobileNumber"].ToString(),
                                    City = sdr["City"].ToString(),
                                    IsActive = Convert.ToInt32(sdr["IsActive"])
                                });
                            }

                            if (sdr.NextResult())
                            {
                                while(sdr.Read())
                                { 
                                totalrows = Convert.ToInt32(sdr[0]);
                                }
                            }
                        }

                        conn.Close();
                        return Json(new {success = true,  data, recordsTotal = totalrows, recordsFiltered = totalrows});
                    }
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, msg = e.Message.ToString() });
            }
        }
        [HttpPost]
        public ActionResult SaveCustomer(Customer data) {
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = data.ID == 0 ? "CustomerCreate" : "CustomerUpdate";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@ID", data.ID);
                        cmd.Parameters.AddWithValue("@FirstName", data.FirstName);
                        cmd.Parameters.AddWithValue("@LastName", data.LastName);
                        cmd.Parameters.AddWithValue("@MobileNumber", data.MobileNumber);
                        cmd.Parameters.AddWithValue("@City", data.City);
                        cmd.Parameters.AddWithValue("@IsActive", data.IsActive);
                        cmd.ExecuteNonQuery();

                        conn.Close();
                        return Json(new { success = true });
                    }
                }
            }
            catch (Exception e)
            {
                return Json( new { success = false, msg = e.Message.ToString() });
            }
        }
    }
}
