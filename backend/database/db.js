const mongoose = require("mongoose");
const dbConnection = "mongodb://127.0.0.1:27017/task_manager";

mongoose.connect(dbConnection, {
    useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
  })
  .then((suc) => {
    console.log("Success");
  })
  .catch((err) => {
    console.log("Error : ", err);
  });
