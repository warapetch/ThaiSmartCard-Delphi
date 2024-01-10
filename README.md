
# ThaiSmartCard-Delphi
Thai Smart Card Reader Delphi Component

## เป็นคอมโพเนนท์ ที่พัฒนาใช้กับโปรแกรมเดลไฟ
ใช้อ่านข้อมูลจากบัตรประชาชน คนไทย

📌 มีเฉพาะเวอร์ชั่น
```xml
D10.3
D10.4
D11.0
```

📌 เครดิต APDU ของคุณ chakphanu
```xml
https://github.com/chakphanu/ThaiNationalIDCard/blob/master/APDU.md
```

📌 APDU ผมนำมาอัพเดต

https://github.com/warapetch/ThaiSmartCard-Delphi/blob/main1/APDU.md


🔷 หมายเหตุ / ปัญหา
```xml
 03/12/2564 21.00 น *Event OnCardResultValue* แก้ไขปัญหาได้แล้ว
 ```
* บัตรผู้สูงอายุ ไม่ทราบวันเดือนเกิด วันเกิด จะมีเฉพาะปี หรือ เป็นช่องว่าง
* บัตรผู้สูงอายุ ที่อายุมากกว่า 75 ปี วันหมดอายุ อาจเป็นช่องว่าง


🔷 **`โปรแกรม ThaiSmartCard Explorer`**  \
สามารถมองเห็นได้เฉพาะส่วนที่เป็น Public  \
(<mark>เท่าที่เห็นบนหน้าบัตรประชาชน </mark>)

|  ฟิลด์  		 | APDU                 |
|--------------|---------------------|
| เลขบัตร		 | 80 B0 00 04 02 00 0D |
| ชื่อนามสกุล (TH)| 80 B0 00 11 02 00 64 |
| ชื่อนามสกุล (EN)| 80 B0 00 75 02 00 64 |
| วันเกิด        | 80 B0 00 D9 02 00 08 |
| เพศ         | 80 B0 00 E1 02 00 01 |
| หน่วยงานออกบัตร	| 80 B0 00 F6 02 00 64 |
| วันออกบัตร		| 80 B0 01 67 02 00 08 |
| วันหมดอายุ	| 80 B0 01 6F 02 00 08 |
| ศาสนา		| 80 B0 01 77 02 00 02 |
| ที่อยู่		| 80 B0 15 79 02 00 A0 |
| เลขใต้บัตร		| 80 B0 16 19 02 00 0E |
|

* ข้อมูลอื่นๆ
> รหัสหน่วยงาน [<mark>เห็น</mark>] \
> ลายเซนต์ผู้อนุมัติ [<mark>เห็น</mark>] \
> ลายนิ้วมือ [<mark>ไม่เห็น</mark>]  \
> และอื่นๆ [<mark>ลองค้นหาดู</mark>]



## เนื้อหา + คลิป บน ยูทูป
🔷 วิดีโอ
📌 โปรแกรมอ่านบัตรประชาชน คนไทย - ไพธอน <br>

[![cover](http://img.youtube.com/vi/zmTl_pVMHV0/0.jpg)](https://www.youtube.com/watch?v=zmTl_pVMHV0 "Click to Play Video")


🔷 FaceBook  \
https://www.facebook.com/born2dev

🔷 YouTube  \
https://www.youtube.com/c/HowToCodeDelphi

