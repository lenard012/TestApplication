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
                                    CustomerID = Convert.ToInt32(sdr["CustomerID"]),
                                    FullName = sdr["FullName"].ToString(),
                                    DeliveryDate = Convert.ToDateTime(sdr["DeliveryDate"]).ToString("dd/MM/yyyy"),
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
        public ActionResult SaveOrder(Order OrderData, List<Order> ItemData)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(config.GetValue<string>("TestConnection")))
                {
                    conn.Open();
                    using (SqlCommand cmd = conn.CreateCommand())
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.CommandText = OrderData.ID == 0 ? "OrderCreate" : "OrderUpdate";
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@ID", OrderData.ID);
                        cmd.Parameters.AddWithValue("@CustomerID", OrderData.CustomerID);
                        cmd.Parameters.AddWithValue("@DeliveryDate", OrderData.DeliveryDate);
                        cmd.Parameters.AddWithValue("@Status", OrderData.Status);
                        cmd.Parameters.AddWithValue("@Amount", OrderData.Amount);

                        SqlParameter OrderID = cmd.Parameters.Add("@OrderID", SqlDbType.Int);
                        OrderID.Direction = ParameterDirection.Output;

                        cmd.ExecuteNonQuery();
                        int i = 0;
                        foreach (Order x in ItemData)
                        {
                            
                            try
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.CommandText = "OrderListCreate";
                                cmd.Parameters.Clear();
                                cmd.Parameters.AddWithValue("@OrderID", Convert.ToInt32(OrderID.Value));
                                cmd.Parameters.AddWithValue("@ItemID", x.ItemID);
                                cmd.Parameters.AddWithValue("@Quantity", x.Quantity);
                                cmd.Parameters.AddWithValue("@Amount", x.Amount);
                                cmd.Parameters.AddWithValue("@i", i);
                                cmd.ExecuteNonQuery();

                                i++;
                            }
                            catch (Exception err)
                            {
                                throw new InvalidOperationException(err.Message);
                            }
                            finally
                            {

                                cmd.Dispose();
                            }
                        }

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
                                    ItemID = Convert.ToInt32(sdr["ItemID"]),
                                    Name = sdr["Name"].ToString(),
                                    Quantity = Convert.ToInt32(sdr["Quantity"]),
                                    Amount = Convert.ToDecimal(sdr["Price"])
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
