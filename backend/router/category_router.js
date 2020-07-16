const categoryRouter = require("express").Router();
const categoryController = require("../controllers/category_controller");

categoryRouter.post("/addNewCategory", categoryController.addNewCategory);
categoryRouter.get("/listAllCategories", categoryController.listAllCategories);

module.exports = categoryRouter;
