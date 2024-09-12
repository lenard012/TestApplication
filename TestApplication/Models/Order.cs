using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TestApplication.Models
{
    public class Order : Product
    {
        public string DeliveryDate { get; set; }
        public int Status { get; set; }
        public Decimal Amount { get; set; }
        public int Quantity { get; set; }
    }
}
