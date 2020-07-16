const catchError = (err, req, res, next) => {
    console.log(err);

    //unique değer kontrolü
    if (err.code === 11000) {
        return res.status(400).json({
            mesaj: "Unique başlık girmelisiniz",
            islemKodu: 400
        });
    }

    return res.status(err.statusCode).json({
        mesaj: err.message,
        islemKodu: err.statusCode
    });
}

module.exports = catchError;