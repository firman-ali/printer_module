package com.avatarsolution.printer_module

import android.content.Context
import android.graphics.Bitmap
import com.common.apiutil.printer.UsbThermalPrinter
import com.google.zxing.BarcodeFormat
import com.google.zxing.EncodeHintType
import com.google.zxing.MultiFormatWriter
import com.google.zxing.WriterException
import java.util.Hashtable

class PrinterHelperTelpoImpl(private val context: Context) : PrinterHelper {
    companion object {
        private var paperSizeSmall = 34
        private var paperSizeLarge = 32
        fun formatLeftRight(msg1: String, msg2: String): String {
            val leftPadding = paperSizeSmall - msg1.length - msg2.length
            if (leftPadding >= 0) {
                return msg1 + " ".repeat(leftPadding) + msg2
            } else {
                val leftTrimmed = msg1.take(paperSizeSmall - msg2.length)
                return leftTrimmed + msg2
            }
        }

        fun formatThreeLine(
            leftText: String,
            centerText: String,
            rightText: String
        ) : String {
            var formattedText = leftText
            val spaceAvailable = paperSizeSmall -
                    (centerText.length + rightText.length) -
                    formattedText.length
            val midSpaceAvailable = spaceAvailable / 2
            for (i in 0 until spaceAvailable) {
                formattedText += if (i == midSpaceAvailable) {
                    " $centerText"
                } else {
                    " "
                }
            }
            formattedText += rightText
            return formattedText
        }

        fun strLine(): String {
            return String(CharArray(paperSizeLarge)).replace("\u0000", "-")
        }
    }

    override fun getUsbDevices(): MutableList<Map<String, Any>> {
        return  arrayListOf()
    }

    override fun getSerialDevices(): MutableList<String> {
        return arrayListOf()
    }

    override fun connectPrinter(): Int {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.init80mmUsbPrinter(context)
//            ThermalPrinter.start()
//        }
        return 0
    }

    override fun connectUsbPrinter(deviceId: String): Int { return -1 }

    override fun connectSerialPrinter(deviceAddress: String, baudRate: Int, flowControl: Int): Int { return -1 }

    override fun connectSocketPrinter(deviceAddress: String, devicePort: Int): Int { return -1 }

    override fun initPrinter() { }

    override fun deInitPrinter() {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.stop()
//        }
    }

    override fun reset() {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.reset()
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.reset()
//        }
    }

    override fun print(data: String, fontSize: Int, align: Int, isBold: Boolean, printSize: Int?) {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.setAlgin(align)
//            if(fontSize <= 21) ThermalPrinter.setFontSize(1)
//            else ThermalPrinter.setFontSize(2)
//            ThermalPrinter.setBold(isBold)
//            ThermalPrinter.addString(data)
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.setAlgin(align)
        printerHelper.setTextSize(fontSize)
        printerHelper.setBold(isBold)
        printerHelper.addString(data)
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
//        }
    }

    override fun startPrint() {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.setGray(5)
//            ThermalPrinter.printString()
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
        printerHelper.printString()
//        }
    }

    override fun printStrLine(printSize: Int?) {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.setGray(5)
//            ThermalPrinter.setFontSize(1)
//            ThermalPrinter.setBold(false)
//            ThermalPrinter.addString(strLine())
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
        printerHelper.setTextSize(24)
        printerHelper.setBold(false)
        printerHelper.addString(strLine())
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
//        }
    }

    override fun printLeftRight(data1: String, data2: String, printSize: Int?) {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.setGray(5)
//            ThermalPrinter.setFontSize(1)
//            ThermalPrinter.setBold(false)
//            ThermalPrinter.addString(formatLeftRight(data1, data2))
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
        printerHelper.setTextSize(21)
        printerHelper.setBold(false)
        printerHelper.addString(formatLeftRight(data1, data2))
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
//        }
    }

    override fun printThreeLineText(data1: String, data2: String, data3: String, printSize: Int?) {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.setGray(5)
//            ThermalPrinter.setFontSize(1)
//            ThermalPrinter.setBold(false)
//            ThermalPrinter.addString(formatThreeLine(data1, data2, data3))
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
        printerHelper.setTextSize(21)
        printerHelper.setBold(false)
        printerHelper.addString(formatThreeLine(data1, data2, data3))
        printerHelper.setGray(5)
        printerHelper.setMonoSpace(true)
//        }
    }

    override fun printSingleBitmap(image: Bitmap, align: Int, printSize: Int?) {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.reset()
//            ThermalPrinter.setGray(5)
//            ThermalPrinter.setAlgin(align)
//            ThermalPrinter.printLogo(image, 0)
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.reset()
        printerHelper.setGray(5)
        printerHelper.setAlgin(align)
        printerHelper.printLogo(image, false)
//        }
    }

    override fun printQr(data: String, align: Int, size: Int, printSize: Int?) {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.reset()
//            ThermalPrinter.setGray(5)
//            ThermalPrinter.setAlgin(align)
//            val bitmap: Bitmap = createCode(data, BarcodeFormat.QR_CODE, size, size)
//            ThermalPrinter.printLogo(bitmap, 0)
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.reset()
        printerHelper.setGray(5)
        printerHelper.setAlgin(align)
        val bitmap: Bitmap = createCode(data, BarcodeFormat.QR_CODE, size, size)
        printerHelper.printLogo(bitmap, false)
//        }
    }

    override fun getStatus(): Int {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            return ThermalPrinter.checkStatus()
//        } else {
        return UsbThermalPrinter(context).checkStatus()
//        }
    }

    override fun feedPaper(size: Int, printSize: Int?) {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.walkPaper(size)
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.walkPaper(size)
//        }
    }

    override fun partialCut() {
//        val printerCheck = SystemUtil.checkIs80mmCommonPrinter(context)
//        if(printerCheck) {
//            ThermalPrinter.paperCut()
//        } else {
        val printerHelper = UsbThermalPrinter(context)
        printerHelper.paperCut()
//        }
    }

    override fun printBitmap(bitmap: ByteArray, with: Int, height: Int, printSize: Int?) { }

    override fun enterPrinterBuffer() { }

    override fun commitPrinterBuffer(callback: (Int) -> Unit) { }

    override fun exitPrinterBuffer() { }

    @Throws(WriterException::class)
    fun createCode(str: String?, type: BarcodeFormat?, bmpWidth: Int, bmpHeight: Int): Bitmap {
        val mHashtable = Hashtable<EncodeHintType, String?>()
        mHashtable[EncodeHintType.CHARACTER_SET] = "UTF-8"
        val matrix = MultiFormatWriter().encode(str, type, bmpWidth, bmpHeight, mHashtable)
        val width = matrix.width
        val height = matrix.height
        val pixels = IntArray(width * height)
        for (y in 0 until height) {
            for (x in 0 until width) {
                if (matrix[x, y]) {
                    pixels[y * width + x] = -0x1000000
                } else {
                    pixels[y * width + x] = -0x1
                }
            }
        }
        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        bitmap.setPixels(pixels, 0, width, 0, 0, width, height)
        return bitmap
    }
}