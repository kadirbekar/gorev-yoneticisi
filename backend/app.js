var express = require("express");
var app = express();

app.use(express.json()); //json verilerini kullanabilmek için
app.use(express.urlencoded({ extended: true })); //xml olarak gönderilen değerler için
require("./database/db"); //veritabanını çağırdık

//hataların tek bir dosyadan kontrol edilebilmesi için hata katmanı import edildi
const errorMiddleWare = require("./middlewares/error_middle_ware");

//routerlerimizi import edip gerekli yönlendirmeleri yapacaz
const taskRouter = require("./router/task_router");
const categoryRouter = require("./router/category_router");

//sayfa yönlendirmelerinin yapıldığı kısım
app.use("/api/task", taskRouter);
app.use("/api/category", categoryRouter);

//yapılan işlemlerde bir hata varsa süreci bitirmeden errorMiddleWare katmanına yönlendirme yapıyoruz.
app.use(errorMiddleWare);

const PORT = process.env.PORT || 3000;
app.listen(PORT, (suc, err) => {
  if (err) throw err;
  console.log(`Server is running on ${PORT} port`);
});
