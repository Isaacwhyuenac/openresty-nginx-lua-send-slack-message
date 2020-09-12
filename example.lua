attachments = {
    {
        title = "Abnormal long query running in Data warehouse",
        color = "danger",
        fields = {
        {
        title = "Status",
        value = "ALARM",
        short = true
        },
        {
        title = "Reason",
        value = "Threshold Crossed: 5 out of the last 5 datapoints were greater than the threshold (400000.0). The most recent datapoints which crossed the threshold: [624630.0 (21/05/20 18:31:00), 1223375.0 (21/05/20 18:26:00), 1054630.0 (21/05/20 18:21:00), 1893750.0 (21/05/20 18:16:00), 2126585.0 (21/05/20 18:11:00)] (minimum 5 datapoints for OK -> ALARM transition)."
        },
        {
        title = "Function Name",
        value = ""
        },
        {
        title = "pid",
        short = true,
        value = 28616
        },
        {
        title = "txn_owner",
        short = true,
        value = "report"
        },
        {
        title = "tablename",
        value = "dw_data_warehouse_kpi_dw_archive_article_5aeed0b0aefdf, dw_data_warehouse_kpi_dw_archive_article_5aeed0b0aefdf, dw_data_warehouse_kpi_article_view_5aeed0b0d1c57, dw_data_warehouse_kpi_article_view_5aeed0b0d1c57, dw_data_warehouse_kpi_article_info_view_5aeed0b087aa6, dw_data_warehouse_kpi_article_info_view_5aeed0b087aa6"
        }
      },
    mrkdwn_in = {
        "text"
    },
    text = "```fetch 10000 in \"SQL_CUR4\";```"
    }
}