package com.avatarsolution.printer_module

import android.graphics.Bitmap

interface PrinterHelper {
    fun getUsbDevices(): MutableList<Map<String, Any>>
    fun getSerialDevices(): MutableList<String>
    fun connectPrinter(): Int
    fun connectUsbPrinter(deviceId: String): Int
    fun connectSerialPrinter(deviceAddress: String, baudRate: Int, flowControl: Int): Int
    fun connectSocketPrinter(deviceAddress: String, devicePort: Int): Int
    fun initPrinter()
    fun deInitPrinter()
    fun reset()
    fun print(
        data: String,
        fontSize: Int,
        align: Int,
        isBold: Boolean,
        printSize: Int? = null
    )
    fun startPrint()
    fun printStrLine(printSize: Int? = null)
    fun printLeftRight(data1: String, data2: String, printSize: Int? = null)
    fun printThreeLineText(data1: String, data2: String, data3: String, printSize: Int? = null)
    fun printSingleBitmap(image: Bitmap, align: Int, printSize: Int? = null)
    fun printQr(data: String, align: Int, size: Int, printSize: Int? = null)
    fun getStatus(): Int
    fun feedPaper(size: Int, printSize: Int? = null)
    fun partialCut()
    fun printBitmap(bitmap: ByteArray, with: Int, height: Int, printSize: Int? = null)
    fun enterPrinterBuffer()
    fun commitPrinterBuffer(callback: (Int) -> Unit)
    fun exitPrinterBuffer()
}