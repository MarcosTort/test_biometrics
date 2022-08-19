final jsonExample = {
    "BankLogo64": "data:image/png;base64,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",
    "Language": "en",
    "Columns": [
        {
            "header": "Transaction Id",
            "dataKey": "TransactionId"
        },
        {
            "header": "Date",
            "dataKey": "Date"
        },
        {
            "header": "Description",
            "dataKey": "Description"
        },
        {
            "header": "Amount",
            "dataKey": "Amount"
        },
        {
            "header": "Fee",
            "dataKey": "Fees"
        },
        {
            "header": "Time",
            "dataKey": "Time"
        },
        {
            "header": "Reference Information",
            "dataKey": "ReferenceInfo"
        }
    ],
    "Rows": [
        {
            "TransactionId": 827749735,
            "Date": "Jul 8, 2022",
            "Description": "Card to Card Transfer",
            "Amount": "(123.00)",
            "Fees": "(2.50)",
            "Time": "05:56:11 PM",
            "ReferenceInfo": "Funds Transfer to Francisco Canaro"
        },
        {
            "TransactionId": 827749618,
            "Date": "Jun 21, 2022",
            "Description": "Funds Transfer - Operator",
            "Amount": "25.00",
            "Fees": "0.00",
            "Time": "11:02:26 PM",
            "ReferenceInfo": "Funds transfer from Anibal Rawlings"
        }
    ]
};