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
    public class OrderController : Controller
    {
        public IConfiguration config;
        public OrderController(IConfiguration configuration)
        {
            config = configuration;
        }

        public IActionResult Order()
        {
            return View();
        }

        public ActionResult GetOrder()
        {
            List<Order> data = new List<Order>();
            int totalrows = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "OrderGet";

                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new Order
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    FullName = sdr["FullName"].ToString(),
                                    DeliveryDate = sdr["DeliveryDate"].ToString(),
                                    Status = Convert.ToInt32(sdr["Status"]),
                                    Amount = Convert.ToDecimal(sdr["Amount"])
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
        public ActionResult SaveOrder(Order data)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = data.ID == 0 ? "OrderCreate" : "OrderUpdate";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@ID", data.ID);
                        cmd.Parameters.AddWithValue("@Name", data.Name);
                        cmd.Parameters.AddWithValue("@Code", data.Code);
                        cmd.Parameters.AddWithValue("@UnitPrice", data.UnitPrice);
                        cmd.Parameters.AddWithValue("@IsActive", data.IsActive);
                        cmd.ExecuteNonQuery();

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

        public ActionResult GetOrderList(int OrderID)
        {
            List<Order> data = new List<Order>();
            int totalrows = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = "OrderListGet";
                        cmd.Parameters.AddWithValue("@OrderID", OrderID);

                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            while (sdr.Read())
                            {
                                data.Add(new Order
                                {
                                    ID = Convert.ToInt32(sdr["ID"]),
                                    FullName = sdr["FullName"].ToString(),
                                    DeliveryDate = sdr["DeliveryDate"].ToString(),
                                    Status = Convert.ToInt32(sdr["Status"]),
                                    Amount = Convert.ToDecimal(sdr["Amount"])
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
    }
}
