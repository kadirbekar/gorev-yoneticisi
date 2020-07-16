const Category = require("../models/category_model");
const createError = require("http-errors");

//yeni kategori ekliyoruz
const addNewCategory = async (req, res, next) => {
  try {
    const newCategory = new Category(req.body);

    const result = await newCategory.save();

    if (result) {
      return res.status(201).json({
        result: true,
        message: "Yeni kategori eklendi",
        islemKodu: 201,
      });
    } else {
      return res.status(400).json({
        result: false,
        message: "Lütfen tekrar deneyiniz.",
        islemKodu: 400,
      });
    }
  } catch (error) {
    next(error);
  }
};

//bütün kategorileri listele
const listAllCategories = async(req,res,next) => {
  try {
    const data = await Category.find({});
    return res.status(200).json(data);
  } catch (error) {
    next(createError(500,error));
  }
}

module.exports = {
  addNewCategory,
  listAllCategories
};
