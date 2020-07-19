const Category = require("../models/category_model");
const createError = require("http-errors");
var messages = require('../message_constants/constants');

//add new category
const addNewCategory = async (req, res, next) => {
  try {
    const newCategory = new Category(req.body);

    const result = await newCategory.save();

    if (result) {
      return res.status(201).json({
        result: true,
        message: messages.success_messages.Success,
        islemKodu: 201,
      });
    } else {
      return res.status(400).json({
        result: false,
        message: messages.error_messages.Error,
        islemKodu: 400,
      });
    }
  } catch (error) {
    next(error);
  }
};

//list all categories
const listAllCategories = async (req, res, next) => {
  try {
    
    const data = await Category.find({});
    if (data.length == 0 || data == undefined) {
      const addCategories = await Category.insertMany([
        { name: "daily" },
        { name: "weekly" },
        { name: "monthly" },
      ]);
      if (addCategories) {
        const data = await Category.find({});
        return res.status(200).json(data);
      }
    } else {
      return res.status(200).json(data);
    }
  } catch (error) {
    next(createError(500, error));
  }
};

module.exports = {
  addNewCategory,
  listAllCategories,
};
