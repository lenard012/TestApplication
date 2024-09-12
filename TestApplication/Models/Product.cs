using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TestApplication.Models
{
    public class Product : Customer
    {
        public string Name { get; set; }
        public string Code { get; set; }
        public Decimal UnitPrice { get; set; }

    }
}
