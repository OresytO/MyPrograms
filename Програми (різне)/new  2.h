/* Login details */
    String UserName = "user"; //"db_user_name";
    String PassWord = ""; //"db_pass_word";
    String Server = "Rebok2_DB";

    /* Connection String */ //Provider=MSDASQL.1
    String ConnString ="Provider=MSDASQL.1;";
    ConnString += "Persist Security Info=False;";
    ConnString += "User ID=%s;"; //user;";
    ConnString += "Data Source=%s;"; //Rebok2_DB;";
    ConnString += "Mode=ReadWrite;";
    ConnString += "Initial Catalog=rebok2_db";
    /*
    String ConnString =
        "Provider=MSDASQL.1;Persist Security Info=False;";
    ConnString +=
        "User ID=%s;Password=%s;Data Source=%s;Use Procedure for Prepare=1;";
    ConnString +=
        "Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;";
    ConnString +=
        "Tag with column collation when possible=False";
    */
    /* SQL Query */

/*create procedure ProG()
begin 
SELECT * FROM hs_hr_employee_leave_quota;
end;//
*/
    String SQLStr;
    SQLStr += "delimiter // ";
    SQLStr += "USE rebok2_db;// ";
    SQLStr += "SELECT `i?`.`iacaa_eiiiai??`, `i?`.`?_neeaao`, `i?`.`aa?ana` "; // , `vr`.`aeae_?ic?aooie?a
    SQLStr += "FROM `ia?aa?cieee` `i?` ;//"; // NATURAL JOIN `aeae_?ic?aooie?a` `vr`
    SQLStr += "delimiter ;";
    /* All ADO variables */
    TADOConnection* ADOConn;
    TADOQuery* ADOQuery;
    TDataSource* DataSrc;
    TParameter* Param;

    /* Create an ADO connection */
    ADOConn = new TADOConnection(this);

    /* Setup the connection string */
    ADOConn->ConnectionString = Format(ConnString,
        ARRAYOFCONST((UserName, Server))); // , PassWord

    /* Disable login prompt */
    ADOConn->LoginPrompt = False;

    try
    {
        ADOConn->Connected = true;
    }
    catch (EADOError *e)
    {
        MessageDlg("Error while connecting", mtError,
                      TMsgDlgButtons() << mbOK, 0);
        return;
    }
    Query1->SQL->Text = SQLStr;
    Query1->Open();
    /* Create the query */
    ADOQuery = new TADOQuery(this);
    ADOQuery->Connection = ADOConn;
    //ADOQuery->SQL->Add(SQLStr);

    /* Update the parameter that was parsed from the SQL query: AnId */
    /*
    Param = ADOQuery->Parameters->ParamByName("AnId");
    Param->DataType = ftInteger;
    Param->Value = 1;
    */
    /* Set the query to Prepared - will improve performance */
    ADOQuery->Prepared = true;
    /*
    try
    {
        ADOQuery->Active = true;
    }
    catch (EADOError *e)
    {
        MessageDlg("Error while connecting", mtError,
                      TMsgDlgButtons() << mbOK, 0);
        return;
    }
    */
    /* Create the data source */
    DataSrc = new TDataSource(this);
    DataSrc->DataSet = ADOQuery;
    DataSrc->Enabled = true;

    /* Finally initilalize the grid */
    DBGrid1->DataSource = DataSrc;
    /*
	String con_str;
    con_str = "Provider=MSDASQL.1; ";
    con_str += "Persist Security Info=False;";
    con_str += "User ID=user;";
    con_str += "Data Source=Rebok2_DB;";
    con_str += "Mode=ReadWrite;";
    con_str += "Initial Catalog=rebok2_db;";
    ADOConnection1->ConnectionString = con_str;
    //ADOQuery1->SQL->SetText("SHOW TABLES;");
    */