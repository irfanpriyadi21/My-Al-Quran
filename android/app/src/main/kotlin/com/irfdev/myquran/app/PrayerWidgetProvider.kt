package com.irfdev.myquran.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class PrayerWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            try {
                val views = RemoteViews(context.packageName, R.layout.prayer_widget).apply {
                    val cityName = widgetData.getString("city_name", "KOTA JAKARTA") ?: "KOTA JAKARTA"
                    val nextPrayerName = widgetData.getString("next_prayer_name", "Shalat Selanjutnya") ?: "Shalat Selanjutnya"
                    val nextPrayerTime = widgetData.getString("next_prayer_time", "--:--") ?: "--:--"
                    val subuh = widgetData.getString("subuh", "04:35") ?: "04:35"
                    val dzuhur = widgetData.getString("dzuhur", "11:58") ?: "11:58"
                    val ashar = widgetData.getString("ashar", "15:15") ?: "15:15"
                    val maghrib = widgetData.getString("maghrib", "17:58") ?: "17:58"
                    val isya = widgetData.getString("isya", "19:08") ?: "19:08"

                    setTextViewText(R.id.widget_city, cityName)
                    setTextViewText(R.id.widget_next_prayer_name, nextPrayerName)
                    setTextViewText(R.id.widget_next_prayer_time, nextPrayerTime)
                    setTextViewText(R.id.widget_subuh, subuh)
                    setTextViewText(R.id.widget_dzuhur, dzuhur)
                    setTextViewText(R.id.widget_ashar, ashar)
                    setTextViewText(R.id.widget_maghrib, maghrib)
                    setTextViewText(R.id.widget_isya, isya)

                    // Launch App Intent
                    val intent = Intent(context, MainActivity::class.java).apply {
                        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                    }
                    val flags = PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                    val pendingIntent = PendingIntent.getActivity(context, 0, intent, flags)
                    setOnClickPendingIntent(R.id.widget_root, pendingIntent)
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }
}
