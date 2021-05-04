using System;
using System.Collections.Generic;
using System.Text;

namespace APIwithDB
{
    public class Models
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public double price { get; set; }
    }
    public class CreateProductModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public double price { get; set; }
    }
    public class UpdateProductModel
    {
        public int id { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public double price { get; set; }
    }
}
