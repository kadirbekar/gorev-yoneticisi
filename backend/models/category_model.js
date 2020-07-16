const mongoose = require("mongoose");
const Schema = mongoose.Schema;

//Kategori için alanlarımızı belirledik
const CategorySchema = new Schema(
  {
    name: {
      type: String,
      trim: true,
      unique: true,
      required: true,
    },
    createdDate: {
      type: Date,
      default: Date.now,
    },
  },
  { collection: "category",versionKey : false }
);

const Category = mongoose.model("Category", CategorySchema);

module.exports = Category;
