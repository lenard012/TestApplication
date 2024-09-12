using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using TestApplication.Models;


namespace TestApplication.Controllers
{
    public class ProductController : Controller
    {
        public IConfiguration config;
        public ProductController(IConfiguration configuration)
        {
            config = configuration;
        }

        public IActionResult Product()
        {
            return View();
        }

        public ActionResult GetProduct()
        {
            List<Product> data = new List<Product>();
            int totalrows = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "ProductGet";

                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new Product
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    Name = sdr["Name"].ToString(),
                                    Code = sdr["Code"].ToString(),
                                    UnitPrice = Convert.ToDecimal(sdr["UnitPrice"]),
                                    IsActive = Convert.ToInt32(sdr["IsActive"])
                                });
                            }

                            if (sdr.NextResult())
                            {
                                while (sdr.Read())
                                {
                                    totalrows = Convert.ToInt32(sdr[0]);
                                }
                            }
                        }

                        conn.Close();
                        return Json(new { success = true, data, recordsTotal = totalrows, recordsFiltered = totalrows });
                    }
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, msg = e.Message.ToString() });
            }
        }
        [HttpPost]
        public ActionResult SaveProduct(Product data)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = data.ID == 0 ? "ProductCreate" : "ProductUpdate";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@ID", data.ID);
                        cmd.Parameters.AddWithValue("@Name", data.Name);
                        cmd.Parameters.AddWithValue("@Code", data.Code);
                        cmd.Parameters.AddWithValue("@UnitPrice", data.UnitPrice);
                        cmd.Parameters.AddWithValue("@IsActive", data.IsActive);
                        SqlParameter ErrorMessage = cmd.Parameters.Add("@ErrorMsg", SqlDbType.VarChar, 1000);
                        SqlParameter Error = cmd.Parameters.Add("@Error", SqlDbType.Bit);
                        Error.Direction = ParameterDirection.Output;
                        ErrorMessage.Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();

                        if (Convert.ToBoolean(Error.Value))
                            return Json(new { success = false, msg = ErrorMessage.Value.ToString() });

                        conn.Close();
                        return Json(new { success = true });
                    }
                }
            }
            catch (Exception e)
            {
                return Json(new { success = false, msg = e.Message.ToString() });
            }
        }
    }
}
