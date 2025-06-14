package com.avatarsolution.printer_module

import android.content.Context
import android.graphics.Bitmap
import com.imin.printer.PrinterHelper as IminPrinterHelper

class PrinterHelperIminImpl(private val context: Context) : PrinterHelper {
    companion object {
        private var paperSize = 32
        fun formatLeftRight(msg1: String, msg2: String): String {
            val leftPadding = paperSize - msg1.length - msg2.length
            if (leftPadding >= 0) {
                return msg1 + " ".repeat(leftPadding) + msg2
            } else {
                val leftTrimmed = msg1.take(paperSize - msg2.length)
                return leftTrimmed + msg2
            }
        }

        fun formatThreeLine(
            leftText: String,
            centerText: String,
            rightText: String
        ) : String {
            var formattedText = leftText
            val spaceAvailable = paperSize -
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
            return String(CharArray(paperSize)).replace("\u0000", "-")
        }
    }

    override fun getUsbDevices(): MutableList<Map<String, Any>> {
        return arrayListOf()
    }

    override fun getSerialDevices(): MutableList<String> {
        return arrayListOf()
    }

    override fun connectPrinter(): Int {
        return if(IminPrinterHelper.getInstance().printerStatus == -1) {
            if (IminPrinterHelper.getInstance().initPrinterService(context)) 0 else -1
        } else {
            IminPrinterHelper.getInstance().printerStatus
        }
    }

    override fun connectUsbPrinter(deviceId: String): Int {
        return -1
    }

    override fun connectSerialPrinter(deviceAddress: String, baudRate: Int, flowControl: Int): Int {
        return -1
    }

    override fun connectSocketPrinter(deviceAddress: String, devicePort: Int): Int {
        return -1
    }

    override fun initPrinter() {}

    override fun deInitPrinter() {
        if(IminPrinterHelper.getInstance().printerStatus != -1) {
            IminPrinterHelper.getInstance().deInitPrinterService(context)
        }
    }

    override fun reset() {
        return
    }

    override fun print(
        data: String,
        fontSize: Int,
        align: Int,
        isBold: Boolean,
        printSize: Int?
    ) {
        IminPrinterHelper.getInstance().setCodeAlignment(align)
        IminPrinterHelper.getInstance().setFontCharSize(fontSize, 0, 0, 0)
        IminPrinterHelper.getInstance().setFontBold(isBold)
        IminPrinterHelper.getInstance().printText(data + "\n",null)
    }

    override fun startPrint() {
        return
    }

    override fun printStrLine(printSize: Int?) {
        IminPrinterHelper.getInstance().setCodeAlignment(1)
        IminPrinterHelper.getInstance().setFontBold(false)
        IminPrinterHelper.getInstance().setFontCharSize(0, 0, 0, 0)
        IminPrinterHelper.getInstance().printText(strLine() + "\n",null)
    }

    override fun printLeftRight(data1: String, data2: String, printSize: Int?) {
        IminPrinterHelper.getInstance().setCodeAlignment(0)
        IminPrinterHelper.getInstance().setFontBold(false)
        IminPrinterHelper.getInstance().setFontCharSize(0, 0, 0, 0)
        IminPrinterHelper.getInstance().printText(formatLeftRight(data1, data2) + "\n",null)
    }

    override fun printThreeLineText(data1: String, data2: String, data3: String, printSize: Int?) {
        IminPrinterHelper.getInstance().setCodeAlignment(0)
        IminPrinterHelper.getInstance().setFontBold(false)
        IminPrinterHelper.getInstance().setFontCharSize(0, 0, 0, 0)
        IminPrinterHelper.getInstance().printText(formatThreeLine(data1, data2, data3) + "\n",null)
    }

    override fun printSingleBitmap(image: Bitmap, align: Int, printSize: Int?) {
        IminPrinterHelper.getInstance().setCodeAlignment(align)
        IminPrinterHelper.getInstance().printBitmap(image, null)
    }

    override fun printQr(data: String, align: Int, size: Int, printSize: Int?) {
        IminPrinterHelper.getInstance().setCodeAlignment(align)
        IminPrinterHelper.getInstance().setQrCodeSize(size)
        IminPrinterHelper.getInstance().printQrCode(data, null)
    }

    override fun getStatus(): Int {
        return IminPrinterHelper.getInstance().printerStatus
    }

    override fun feedPaper(size: Int, printSize: Int?) {
        IminPrinterHelper.getInstance().printAndFeedPaper(size)
    }

    override fun partialCut() {
        IminPrinterHelper.getInstance().partialCut()
    }

    override fun printBitmap(bitmap: ByteArray, with: Int, height: Int, printSize: Int?) { }

    override fun enterPrinterBuffer() {
        IminPrinterHelper.getInstance().enterPrinterBuffer(true)
    }

    override fun commitPrinterBuffer(callback: (Int) -> Unit) {
        IminPrinterHelper.getInstance().commitPrinterBuffer()
    }

    override fun exitPrinterBuffer() {
        IminPrinterHelper.getInstance().exitPrinterBuffer(false)
    }
}