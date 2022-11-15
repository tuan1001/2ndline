import 'package:rcore/views/affiliate/affiliate_screen.dart';

class MultiLang {
  String login(String lang) {
    switch(lang) {
      case 'ru':
        return 'Войти';
      case 'cn':
        return '登录';
      case 'in':
        return 'Gabung';
      case 'th':
        return 'เข้าสู่ระบบ';
      case 'vi':
        return 'Đăng nhập';
      default: 
        return 'Login';
    }
  }
  String username(String lang) {
    switch(lang) {
      case 'ru':
        return 'Имя пользователя';
      case 'cn':
        return '用户名';
      case 'in':
        return 'Nama belakang';
      case 'th':
        return 'ชื่อผู้ใช้';
      case 'vi':
        return "Tên đăng nhập";
      default:
        return 'Username';
    }
  }
  String password(String lang) {
    switch(lang) {
      case 'ru':
        return 'Пароль';
      case 'cn':
        return '密码';
      case 'in':
        return 'Kata sandi';
      case 'th':
        return 'รหัสผ่าน';
      case 'vi':
        return 'Mật khẩu';
      default:
        return 'Password';
    }
  }
  String saveAccount(String lang) {
    switch(lang) {
      case 'ru':
        return 'Сохранить аккаунт';
      case 'cn':
        return '保存帐户？';
      case 'in':
        return 'Simpan akun?';
      case 'th':
        return 'บันทึกบัญชี?';
      case 'vi':
        return 'Lưu tài khoản';
      default:
        return 'Save account?';
    }
  }
  String register(String lang) {
    switch(lang) {
      case 'ru':
        return 'Зарегистрироваться';
      case 'cn':
        return '登记';
      case 'in':
        return 'Daftar';
      case 'th':
        return 'ลงทะเบียน';
      case 'vi':
        return 'Đăng ký';
      default:
        return 'Register';
    }
  }
  String forgotPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Забыли пароль?';
      case 'cn':
        return '忘记密码？';
      case 'in':
        return 'Tidak ingat kata sandi?';
      case 'th':
        return 'ลืมรหัสผ่าน?';
      case 'vi':
        return 'Quên mật khẩu?';
      default:
        return 'Forgot password?';
    }
  }
  String notification(String lang) {
    switch(lang) {
      case 'ru':
        return 'Уведомление';
      case 'cn':
        return '通知';
      case 'in':
        return 'Pemberitahuan';
      case 'th':
        return 'การแจ้งเตือน';
      case 'vi':
        return 'Thông báo';
      default:
        return 'Notification';
    }
  }
  String pleaseEnterUsername(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите имя пользователя!';
      case 'cn':
        return '请输入您的用户名！';
      case 'in':
        return 'Silakan masukkan nama pengguna Anda!';
      case 'th':
        return 'กรุณากรอกชื่อผู้ใช้ของคุณ!';
      case 'vi':
        return 'Vui lòng điền tên đăng nhập!';
      default:
        return 'Please enter your username!';
    }
  }
  String pleaseEnterPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите пароль!';
      case 'cn':
        return '请输入您的密码！';
      case 'in':
        return 'Silakan masukkan kata sandi Anda!';
      case 'th':
        return 'กรุณาใส่รหัสผ่านของคุณ!';
      case 'vi':
        return 'Vui lòng điền mật khẩu!';
      default:
        return 'Please enter your password!';
    }
  }
  String fullName(String lang) {
    switch(lang) {
      case 'ru':
        return 'Фамилия и имя';
      case 'cn':
        return '全名';
      case 'in':
        return 'Nama lengkap';
      case 'th':
        return 'ชื่อเต็ม';
      case 'vi':
        return 'Họ và tên';
      default:
        return 'Full name';
    }
  }
  String confirmPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Подтвердить пароль';
      case 'cn':
        return '确认密码';
      case 'in':
        return 'Konfirmasi sandi';
      case 'th':
        return 'ยืนยันรหัสผ่าน';
      case 'vi':
        return 'Xác nhận mật khẩu';
      default:
        return 'Confirm password';
    }
  }
  String phoneNumber(String lang) {
    switch(lang) {
      case 'ru':
        return 'Номер телефона';
      case 'cn':
        return '电话号码';
      case 'in':
        return 'Nomor telepon';
      case 'th':
        return 'หมายเลขโทรศัพท์';
      case 'vi':
        return 'Số điện thoại';
      default:
        return 'Phone number';
    }
  }
  String alreadyHaveAccount(String lang) {
    switch(lang) {
      case 'ru':
        return 'Есть аккаунт? Войти!';
      case 'cn':
        return '已经有一个帐户？ 登录！';
      case 'in':
        return 'Sudah memiliki akun? Gabung!';
      case 'th':
        return 'มีบัญชีอยู่แล้ว? เข้าสู่ระบบ!';
      case 'vi':
        return 'Đã có tài khoản? Đăng nhập!';
      default:
        return 'Already have an account? Login!';
    }
  }
  String pleaseEnterYourName(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите фамилию и имя!';
      case 'cn':
        return '请输入您的全名！';
      case 'in':
        return 'Silakan masukkan nama lengkap Anda!';
      case 'th':
        return 'กรุณาใส่ชื่อเต็มของคุณ!';
      case 'vi':
        return 'Vui lòng điền họ tên!';
      default:
        return 'Please enter your full name!';
    }
  }
  String pleaseConfirmPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Подтвердить пароль!';
      case 'cn':
        return '请确认您的密码！';
      case 'in':
        return 'Harap konfirmasi kata sandi Anda!';
      case 'th':
        return 'กรุณายืนยันรหัสผ่านของคุณ!';
      case 'vi':
        return 'Vui lòng xác nhận mật khẩu!';
      default:
        return 'Please confirm your password!';
    }
  }
  String pleaseEnterYourPhoneNumber(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите номер телефона!';
      case 'cn':
        return '请输入您的电话号码！';
      case 'in':
        return 'Masukkan nomor telepon anda!';
      case 'th':
        return 'กรุณาใส่หมายเลขโทรศัพท์ของคุณ!';
      case 'vi':
        return 'Vui lòng điền số điện thoại!';
      default:
        return 'Please enter your phone number!';
    }
  }
  String pleaseEnterYourEmail(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите почту!';
      case 'cn':
        return '请输入您的邮箱！';
      case 'in':
        return 'Masukkan email Anda!';
      case 'th':
        return 'กรุณากรอกอีเมล์ของคุณ!';
      case 'vi':
        return 'Vui lòng điền email!';
      default:
        return 'Please enter your email!';
    }
  }
  String confirmPasswordFailed(String lang) {
    switch(lang) {
      case 'ru':
        return 'Пароль не верен!';
      case 'cn':
        return '密码错误确认！';
      case 'in':
        return 'Konfirmasi kata sandi salah!';
      case 'th':
        return 'ยืนยันรหัสผ่านผิด!';
      case 'vi':
        return 'Xác thực mật khẩu sai!';
      default:
        return 'Wrong password confirm!';
    }
  }
  String confirm(String lang) {
    switch(lang) {
      case 'ru':
        return 'Подтвердить';
      case 'cn':
        return '确认';
      case 'in':
        return 'Mengonfirmasi';
      case 'th':
        return 'ยืนยัน';
      case 'vi':
        return 'Xác nhận';
      default:
        return 'Confirm';
    }
  }
  String createOtp(String lang) {
    switch(lang) {
      case 'ru':
        return 'OТП';
      case 'cn':
        return '一次性订单';
      case 'in':
        return 'Pesanan OTP';
      case 'th':
        return 'คำสั่ง OTP';
      case 'vi':
        return 'OTP';
      default:
        return 'OTP order';
    }
  }
  String topUp(String lang) {
    switch(lang) {
      case 'ru':
        return 'Ввести деньги';
      case 'cn':
        return '充值';
      case 'in':
        return 'Isi ulang';
      case 'th':
        return 'เติม';
      case 'vi':
        return 'Nạp tiền';
      default:
        return 'Top-up';
    }
  }
  String otpOrderHistory(String lang) {
    switch(lang) {
      case 'ru':
        return 'История чеков ОТП';
      case 'cn':
        return 'OTP 订单历史';
      case 'in':
        return 'Riwayat Pesanan OTP';
      case 'th':
        return 'ประวัติการสั่งซื้อ OTP';
      case 'vi':
        return 'Lịch sử đơn OTP';
      default:
        return 'OTP orders';
    }
  }
  String transactionHistory(String lang) {
    switch(lang) {
      case 'ru':
        return 'История транзакций';
      case 'cn':
        return '交易记录';
      case 'in':
        return 'Sejarah transaksi';
      case 'th':
        return 'ประวัติการทำรายการ';
      case 'vi':
        return 'Lịch sử giao dịch';
      default:
        return 'Transaction history';
    }
  }
  String holdingNumber(String lang) {
    switch(lang) {
      case 'ru':
        return 'Номера аренды';
      case 'cn':
        return '持有号码';
      case 'in':
        return 'Memegang nomor';
      case 'th':
        return 'ถือเลข';
      case 'vi':
        return 'Các số đã thuê';
      default:
        return 'Holding numbers';
    }
  }
  String logout(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выйти';
      case 'cn':
        return '出口';
      case 'in':
        return 'Keluar';
      case 'th':
        return 'ทางออก';
      case 'vi':
        return 'Thoát';
      default:
        return 'Exit';
    }
  }
  String chooseCountry(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выберите страну';
      case 'cn':
        return '选择国家';
      case 'in':
        return 'Pilih negara';
      case 'th':
        return 'เลือกประเทศ';
      case 'vi':
        return 'Chọn quốc gia';
      default:
        return 'Choose Country';
    }
  }
  String chooseService(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выберите услугу';
      case 'cn':
        return '选择服务';
      case 'in':
        return 'Pilih Layanan';
      case 'th':
        return 'เลือกบริการ';
      case 'vi':
        return 'Chọn dịch vụ';
      default:
        return 'Choose Service';
    }
  }
  String chooseOperator(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выберите оператор';
      case 'cn':
        return '选择运营商';
      case 'in':
        return 'Pilih Operator';
      case 'th':
        return 'เลือกโอเปอเรเตอร์';
      case 'vi':
        return 'Chọn nhà mạng';
      default:
        return 'Choose Operator';
    }
  }
  String useVoiceOTP(String lang) {
    switch(lang) {
      case 'ru':
        return 'Используйте голос ОТП?';
      case 'cn':
        return '使用语音 OTP?';
      case 'in':
        return 'Gunakan OTP suara?';
      case 'th':
        return 'ใช้ OTP เสียง?';
      case 'vi':
        return 'Sử dụng SMS thoại?';
      default:
        return 'Use voice OTP?';
    }
  }
  String chooseHoldTime(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выбрать время аренды?';
      case 'cn':
        return '选择保持时间？';
      case 'in':
        return 'Pilih waktu tunggu?';
      case 'th':
        return 'เลือกเวลาพัก?';
      case 'vi':
        return 'Chọn thời gian giữ số?';
      default:
        return 'Choose hold time?';
    }
  }
  String pleaseWaitOTP(String lang) {
    switch(lang) {
      case 'ru':
        return 'Подождите, пока вы получите OTP-код';
      case 'cn':
        return '请等到你的OTP...';
      case 'in':
        return 'Harap tunggu sampai Anda mendapatkan OTP ...';
      case 'th':
        return 'โปรดรอจนกว่าคุณจะได้รับรหัส OTP...';
      case 'vi':
        return 'Vui lòng đợi cho đến khi nhận được mã OTP';
      default:
        return 'Please wait until you the OTP...';
    }
  }
  String holdThisNumber(String lang) {
    switch(lang) {
      case 'ru':
        return 'Арендовать этот номер';
      case 'cn':
        return '拿着这个号码';
      case 'in':
        return 'Tahan nomor ini';
      case 'th':
        return 'ถือหมายเลขนี้';
      case 'vi':
        return 'Thuê số này';
      default:
        return 'Hold this number';
    }
  }
  String pleaseChooseHoldTime(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выберите время аренды';
      case 'cn':
        return '请选择保留时间';
      case 'in':
        return 'Silakan pilih waktu tunggu';
      case 'th':
        return 'โปรดเลือกเวลาพัก';
      case 'vi':
        return 'Vui lòng chọn thời gian giữ số';
      default:
        return 'Please choose a hold time';
    }
  }
  String expireDaate(String lang) {
    switch(lang) {
      case 'ru':
        return 'Дата истечения срока';
      case 'cn':
        return '到期日期';
      case 'in':
        return 'Tanggal kadaluarsa';
      case 'th':
        return 'วันที่หมดอายุ';
      case 'vi':
        return 'Ngày hết hạn';
      default:
        return 'Expire date';
    }
  }
  String yourPhoneNumber(String lang) {
    switch(lang) {
      case 'ru':
        return 'Номер телефона';
      case 'cn':
        return '电话号码';
      case 'in':
        return 'Nomor telepon';
      case 'th':
        return 'หมายเลขโทรศัพท์';
      case 'vi':
        return 'Số điện thoại';
      default:
        return 'Phone number';
    }
  }
  String orderStatus(String lang) {
    switch(lang) {
      case 'ru':
        return 'Статус';
      case 'cn':
        return '订单状态';
      case 'in':
        return 'Status pemesanan';
      case 'th':
        return 'สถานะการสั่งซื้อ';
      case 'vi':
        return 'Trạng thái';
      default:
        return 'Order status';
    }
  }
  String cancel(String lang) {
    switch(lang) {
      case 'ru':
        return 'Отмена';
      case 'cn':
        return '取消';
      case 'in':
        return 'Membatalkan';
      case 'th':
        return 'ยกเลิก';
      case 'vi':
        return 'Hủy';
      default:
        return 'Cancel';
    }
  }
  String changePassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Изменить пароль';
      case 'cn':
        return '更改密码';
      case 'in':
        return 'Ganti kata sandi';
      case 'th':
        return 'เปลี่ยนรหัสผ่าน';
      case 'vi':
        return 'Đổi mật khẩu';
      default:
        return 'Change password';
    }
  }
  String affiliate(String lang) {
    switch(lang) {
      case 'ru':
        return 'Информация';
      case 'cn':
        return '附属公司';
      case 'in':
        return 'Afiliasi';
      case 'th':
        return 'พันธมิตร';
      case 'vi':
        return 'Giới thiệu';
      default:
        return 'Affiliate';
    }
  }
  String timeLeft(String lang) {
    switch(lang) {
      case 'ru':
        return 'Останное время';
      case 'cn':
        return '剩下的时间';
      case 'in':
        return 'Waktu tersisa';
      case 'th':
        return 'เวลาที่เหลือ';
      case 'vi':
        return 'Thời gian còn lại';
      default:
        return 'Time left';
    }
  }
  String price(String lang) {
    switch(lang) {
      case 'ru':
        return 'Цена';
      case 'cn':
        return '价格';
      case 'in':
        return 'Harga';
      case 'th':
        return 'ราคา';
      case 'vi':
        return 'Giá tiền';
      default:
        return 'Price';
    }
  }
  String oldPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Старый пароль';
      case 'cn':
        return '旧密码';
      case 'in':
        return 'Password lama';
      case 'th':
        return 'รหัสผ่านเก่า';
      case 'vi':
        return 'Mật khẩu cũ';
      default:
        return 'Old password';
    }
  }
  String newPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Новый пароль';
      case 'cn':
        return '新密码';
      case 'in':
        return 'Kata sandi baru';
      case 'th':
        return 'รหัสผ่านใหม่';
      case 'vi':
        return 'Mật khẩu mới';
      default:
        return 'New password';
    }
  }
  String confirmNewPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Подтвердить новый пароль';
      case 'cn':
        return '确认新密码';
      case 'in':
        return 'Konfirmasi password baru';
      case 'th':
        return 'ยืนยันรหัสผ่านใหม่';
      case 'vi':
        return 'Xác nhận mật khẩu mới';
      default:
        return 'Confirm new password';
    }
  }
  String profile(String lang) {
    switch(lang) {
      case 'ru':
        return 'Профиль';
      case 'cn':
        return '轮廓';
      case 'in':
        return 'Profil';
      case 'th':
        return 'ประวัติโดยย่อ';
      case 'vi':
        return 'Cá nhân';
      default:
        return 'Profile';
    }
  }
  String save(String lang) {
    switch(lang) {
      case 'ru':
        return 'Сохранить';
      case 'cn':
        return '节省';
      case 'in':
        return 'Menyimpan';
      case 'th':
        return 'บันทึก';
      case 'vi':
        return 'Lưu';
      default:
        return 'Save';
    }
  }
  String address(String lang) {
    switch(lang) {
      case 'ru':
        return 'Адрес';
      case 'cn':
        return '地址';
      case 'in':
        return 'Alamat';
      case 'th':
        return 'ที่อยู่';
      case 'vi':
        return 'Địa chỉ';
      default:
        return 'Address';
    }
  }
  String dateOfBirth(String lang) {
    switch(lang) {
      case 'ru':
        return 'День рождения';
      case 'cn':
        return '出生日期';
      case 'in':
        return 'Tanggal lahir';
      case 'th':
        return 'วันเกิด';
      case 'vi':
        return 'Ngày sinh';
      default:
        return 'Date of birth';
    }
  }
  String taskID(String lang) {
    switch(lang) {
      case 'ru':
        return 'Код чека';
      case 'cn':
        return '任务编号';
      case 'in':
        return 'ID tugas';
      case 'th':
        return 'รหัสงาน';
      case 'vi':
        return 'Mã đơn';
      default:
        return 'Task ID';
    }
  }
  String transactionMesssage(String lang) {
    switch(lang) {
      case 'ru':
        return 'Пожалуйста, переведите деньги в соответствии с информацией ниже и дождитесь подтверждения вашей транзакции.';
      case 'cn':
        return '请使用以下信息进行转账并等待您的交易被确认';
      case 'in':
        return 'Silakan transfer dengan informasi di bawah ini dan tunggu sampai transaksi Anda dikonfirmasi';
      case 'th':
        return 'กรุณาโอนพร้อมข้อมูลด้านล่างและรอจนกว่าธุรกรรมของคุณจะได้รับการยืนยัน';
      case 'vi':
        return 'Vui lòng chuyển tiền theo thông tin bên dưới và đợi giao dịch của bạn được xác nhận';
      default:
        return 'Please transfer with information below and wait until your transaction is confirmed';
    }
  }
  String bank(String lang) {
    switch(lang) {
      case 'ru':
        return 'Банк';
      case 'cn':
        return '银行';
      case 'in':
        return 'Bank';
      case 'th':
        return 'ธนาคาร';
      case 'vi':
        return 'Ngân hàng';
      default:
        return 'Bank';
    }
  }
  String accountHolder(String lang) {
    switch(lang) {
      case 'ru':
        return 'Владелец счета';
      case 'cn':
        return '账户持有人';
      case 'in':
        return 'Pemilik akun';
      case 'th':
        return 'ผู้ถือบัญชี';
      case 'vi':
        return 'Chủ tài khoản';
      default:
        return 'Account holder';
    }
  }
  String accountNumber(String lang) {
    switch(lang) {
      case 'ru':
        return 'Номер счета';
      case 'cn':
        return '帐号';
      case 'in':
        return 'Nomor akun';
      case 'th':
        return 'หมายเลขบัญชี';
      case 'vi':
        return 'Số tài khoản';
      default:
        return 'Account number';
    }
  }
  String transferContent(String lang) {
    switch(lang) {
      case 'ru':
        return 'Содержимое';
      case 'cn':
        return '传输内容';
      case 'in':
        return 'Mentransfer Konten';
      case 'th':
        return 'โอนเนื้อหา';
      case 'vi':
        return 'Nội dung';
      default:
        return 'Transfer Content';
    }
  }
  String amountToTransfer(String lang) {
    switch(lang) {
      case 'ru':
        return 'Сумма для перевода';
      case 'cn':
        return '转账金额';
      case 'in':
        return 'Jumlah Untuk Transfer';
      case 'th':
        return 'จำนวนเงินโอน';
      case 'vi':
        return 'Số tiền';
      default:
        return 'Amount To Transfer';
    }
  }
  String doYouWantToCancelTransaction(String lang) {
    switch(lang) {
      case 'ru':
        return 'Хотите отменить эту транзакцию?';
      case 'cn':
        return '你想取消交易吗';
      case 'in':
        return 'Apakah Anda ingin membatalkan transaksi?';
      case 'th':
        return 'คุณต้องการที่จะยกเลิกการทำธุรกรรม';
      case 'vi':
        return 'Bạn có muốn hủy giao dịch này?';
      default:
        return 'Do you want to cancel the transaction?';
    }
  }
  String chooseBank(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выберите банк';
      case 'cn':
        return '选择银行转账';
      case 'in':
        return 'Pilih bank yang akan ditransfer';
      case 'th':
        return 'เลือกธนาคารที่จะโอน';
      case 'vi':
        return 'Chọn ngân hàng';
      default:
        return 'Choose bank to transfer';
    }
  }
  String chooseInternationalBank(String lang) {
    switch(lang) {
      case 'ru':
        return 'Международный банкинг';
      case 'cn':
        return '国际银行';
      case 'in':
        return 'Perbankan Internasional';
      case 'th':
        return 'การธนาคารระหว่างประเทศ';
      case 'vi':
        return 'Chuyển khoản quốc tế';
      default:
        return 'International Banking';
    }
  }
  String enterAmountMoney(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводить деньги перевода';
      case 'cn':
        return '输入金额';
      case 'in':
        return 'Masukkan jumlah uang';
      case 'th':
        return 'ใส่จำนวนเงิน';
      case 'vi':
        return 'Nhập số tiền cần chuyển';
      default:
        return 'Enter amount of money';
    }
  }
  String amount(String lang) {
    switch(lang) {
      case 'ru':
        return 'Сумма';
      case 'cn':
        return '数量';
      case 'in':
        return 'Jumlah';
      case 'th':
        return 'จำนวน';
      case 'vi':
        return 'Số tiền';
      default:
        return 'Amount';
    }
  }
  String doYouWantToExist(String lang) {
    switch(lang) {
      case 'ru':
        return 'Хотите выйти из приложения?';
      case 'cn':
        return '您要退出应用程序吗？';
      case 'in':
        return 'Apakah Anda ingin keluar dari aplikasi?';
      case 'th':
        return 'คุณต้องการออกจากแอปพลิเคชันหรือไม่?';
      case 'vi':
        return 'Bạn có muốn thoát ứng dụng ?';
      default:
        return 'Do you want to exit application ?';
    }
  }
  String pleaseEnterNewPassword(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите новый пароль';
      case 'cn':
        return '请输入新密码';
      case 'in':
        return 'Silakan masukkan kata sandi baru';
      case 'th':
        return 'กรุณาใส่รหัสผ่านใหม่';
      case 'vi':
        return 'Vui lòng điền mật khẩu mới';
      default:
        return 'Please enter new password';
    }
  }
  String affiliateLink(String lang) {
    switch(lang) {
      case 'ru':
        return 'Ссылка';
      case 'cn':
        return '关联';
      case 'in':
        return 'Tautan';
      case 'th':
        return 'ลิงค์';
      case 'vi':
        return 'Link';
      default:
        return 'Affiliate';
    }
  }
  String balance(String lang) {
    switch(lang) {
      case 'ru':
        return 'Излишек';
      case 'cn':
        return '平衡';
      case 'in':
        return 'Keseimbangan';
      case 'th':
        return 'สมดุล';
      case 'vi':
        return 'Số dư';
      default:
        return 'Balance';
    }
  }
  String choostBankToWithdraw(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выбрать банк для снятия';
      case 'cn':
        return '选择银行提款';
      case 'in':
        return 'Pilih bank untuk ditarik';
      case 'th':
        return 'เลือกธนาคารที่จะถอน';
      case 'vi':
        return 'Chọn ngân hàng rút';
      default:
        return 'Choose bank to withdraw';
    }
  }
  String content(String lang) {
    switch(lang) {
      case 'ru':
        return 'Содержимое';
      case 'cn':
        return '内容';
      case 'in':
        return 'Isi';
      case 'th':
        return 'เนื้อหา';
      case 'vi':
        return 'Nội dung';
      default:
        return 'Content';
    }
  }
  String emailwalletAddress(String lang) {
    switch(lang) {
      case 'ru':
        return 'Адрес электронной почты/кошелек';
      case 'cn':
        return '电子邮件/钱包地址';
      case 'in':
        return 'Alamat Email/Dompet';
      case 'th':
        return 'ที่อยู่อีเมล/กระเป๋าสตางค์';
      case 'vi':
        return 'Địa chỉ email/ví';
      default:
        return 'Email/Wallet address';
    }
  }
  String withdraw(String lang) {
    switch(lang) {
      case 'ru':
        return 'Снять';
      case 'cn':
        return '提取';
      case 'in':
        return 'Menarik';
      case 'th':
        return 'ถอน';
      case 'vi':
        return 'Rút tiền';
      default:
        return 'Withdraw';
    }
  }
  String member(String lang) {
    switch(lang) {
      case 'ru':
        return 'Член';
      case 'cn':
        return '成员';
      case 'in':
        return 'Anggota';
      case 'th':
        return 'สมาชิก';
      case 'vi':
        return 'Thành viên';
      default:
        return 'Member';
    }
  }
  String pleaseSelectABank(String lang) {
    switch(lang) {
      case 'ru':
        return 'Выберите банк';
      case 'cn':
        return '请选择银行';
      case 'in':
        return 'Silakan pilih bank';
      case 'th':
        return 'กรุณาเลือกธนาคาร';
      case 'vi':
        return 'Vui lòng chọn một ngân hàng';
      default:
        return 'Please select a bank';
    }
  }
  String pleaseEnterEmailWallet(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите адрес электронной почты/кошелек';
      case 'cn':
        return '请输入电子邮件/钱包地址';
      case 'in':
        return 'Silakan masukkan alamat email/dompet';
      case 'th':
        return 'กรุณากรอกอีเมล์/ที่อยู่กระเป๋าเงิน';
      case 'vi':
        return 'Vui lòng nhập địa chỉ email/ví';
      default:
        return 'Please enter email/wallet address';
    }
  }
  String pleaseEnterAmount(String lang) {
    switch(lang) {
      case 'ru':
        return 'Вводите сумму';
      case 'cn':
        return '请输入金额';
      case 'in':
        return 'Silakan masukkan jumlah uang';
      case 'th':
        return 'กรุณากรอกจำนวนเงิน';
      case 'vi':
        return 'Vui lòng nhập số tiền';
      default:
        return 'Please enter amount of money';
    }
  }
  String emailFormatIsNotCorrent(String lang) {
    switch(lang) {
      case 'ru':
        return 'Пожалуйста, введите правильный формат электронной почты';
      case 'cn':
        return '请输入有效的电子邮件地址';
      case 'in':
        return 'Silakan isi alamat email';
      case 'th':
        return 'กรุณาใส่อีเมล์ที่ถูกต้อง';
      case 'vi':
        return 'Vui lòng nhập đúng định dạng email';
      default:
        return 'Please enter a valid email address';
    }
  }
  String minutes(String lang) {
    switch(lang) {
      case 'ru':
        return 'минут';
      case 'cn':
        return '分钟';
      case 'in':
        return 'menit';
      case 'th':
        return 'นาที';
      case 'vi':
        return 'phút';
      default:
        return 'minute(s)';
    }
  }
  String voiceOTP(String lang) {
    switch(lang) {
      case 'ru':
        return 'Голосовое OTP';
      case 'cn':
        return '语音一次性密码';
      case 'in':
        return 'OTP suara';
      case 'th':
        return 'เสียง OTP';
      case 'vi':
        return 'OTP thoại';
      default:
        return 'Voice OTP';
    }
  }
  String loading(String lang) {
    switch(lang) {
      case 'ru':
        return 'Загрузка';
      case 'cn':
        return '正在加载';
      case 'in':
        return 'Memuat';
      case 'th':
        return 'กำลังโหลด';
      case 'vi':
        return 'Đang chờ';
      default:
        return 'Loading';
    }
  }
  String unavailable(String lang) {
    switch(lang) {
      case 'ru':
        return 'Не существует';
      case 'cn':
        return '不可用';
      case 'in':
        return 'Tidak tersedia';
      case 'th':
        return 'ไม่พร้อมใช้งาน';
      case 'vi':
        return 'Không có';
      default:
        return 'Unavailable';
    }
  }
  String touchToList(String lang) {
    switch(lang) {
      case 'ru':
        return 'Нажмите, чтобы прослушать';
      case 'cn':
        return '触摸收听';
      case 'in':
        return 'Sentuh untuk mendengarkan';
      case 'th':
        return 'แตะเพื่อฟัง';
      case 'vi':
        return 'Chạm để nghe';
      default:
        return 'Touch to listen';
    }
  }
  String orderCreateSuccess(String lang) {
    switch(lang) {
      case 'ru':
        return 'Заказ создан успешно';
      case 'cn':
        return '订单创建成功';
      case 'in':
        return 'Pesanan berhasil dibuat';
      case 'th':
        return 'สร้างคำสั่งซื้อสำเร็จแล้ว';
      case 'vi':
        return 'Tạo đơn hàng thành công';
      default:
        return 'Order created successful';
    }
  }
}