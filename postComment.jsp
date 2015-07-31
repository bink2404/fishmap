<%
response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");
response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
response.setHeader("Pragma", "no-cache");
%>

<html>

<head>

<%@ page 
	import = "java.io.*"
	import = "java.sql.*"
%>

<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<meta http-equiv="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">

<title>myfishingmaps - Comment</title>

<meta name="keywords" content="fishing, fish, cast, bait, lure, pike, carp, bass">
<meta name="description" content="myfishingmaps">

<SCRIPT LANGUAGE="JavaScript">
 function putFocus(formInst, elementInst) {
  if (document.forms.length > 0) {
   document.forms[formInst].elements[elementInst].focus();
  }
 }
</script>

</head>

<body bgcolor=white>

<% 
	String url = "jdbc:mysql://localhost/fantas15_dbsql";

	String locationId = request.getParameter("locationId") ;
	String inText = request.getParameter("text") ;
	String inAuthor = request.getParameter("author") ;
	String submit = request.getParameter("submit") ;
	ResultSet rs, rs1 ;
	String insert ;
	String query ;
	StringBuffer writeText = new StringBuffer() ;
	int i ;
	int messageCount ;
	int mId ;
	StringBuffer printSubject = new StringBuffer("") ;
	boolean isMember = false ;
	int id ;

	try
	{
		Class.forName("org.gjt.mm.mysql.Driver") ;
		
		Connection con = DriverManager.getConnection(url, "fantas15_fsn2404", "doosie");

		java.sql.Statement stmt = con.createStatement();

		out.println("<script>putFocus(0,0);</script>") ;

		if ((inText == null) || inText.equals(""))
		{
			out.println("<center>Comment<br><form action=\"postComment.jsp\" method=\"post\" name=\"commentForm\"><table><tr><td><td><textarea name=\"text\" rows=10 cols=60></textarea></table><br><input type=\"submit\" name=\"submit\" value=\"Submit\"> <input type=\"submit\" name=\"submit\" value=\"Cancel\"><input type=\"hidden\" name=\"locationId\" value=\"" + locationId + "\"></form>") ;

			query = "SELECT comment, author, dateTime FROM fm_comments WHERE locationId = " + locationId ;

			rs = stmt.executeQuery(query);

			while (rs.next())
			{
				for (i = 0 ; i < writeText.length() ; i++)
				{
					if (writeText.charAt(i) == '\"')
					{
						writeText.append("''") ;
					}
					else
					{
						writeText.append(inText.charAt(i)) ;
					}
				}

				out.println(writeText + "<br><br>") ;	
			}
		}
		else
		{
			// Check for invalid characters
			for (i = 0 ; i < inText.length() ; i++)
			{
				writeText.append(inText.charAt(i)) ;

				if (inText.charAt(i) == '\'')
				{
					writeText.append('\'') ;
				}
			}

			if (writeText.length() > 0)
			{
				// Get the date/time and convert it to GMT 
				java.text.DateFormat format = java.text.DateFormat.getDateTimeInstance( 
					                java.text.DateFormat.MEDIUM, java.text.DateFormat.MEDIUM); 

				format.setCalendar(java.util.Calendar.getInstance(java.util.TimeZone.getTimeZone("GMT+0"))); 

				java.util.Date date = new java.util.Date(); 
    
				String s = format.format(date) + " (GMT)" ;     

				insert = "INSERT INTO fm_comments (locationId, comment, dateTime, author) VALUES ('" + locationId + "', '" + writeText + "', '" + s + "', '" + inAuthor + "')" ;

				int LinesAffected = stmt.executeUpdate(insert);
			}

			con.close() ;
			response.sendRedirect("tips.jsp?location=" + locationId);
		}

		con.close() ;
	}
	catch (Exception e)
	{
		out.println("Problem reading the database<br>") ;
		out.println(e) ;
	}
%>

<br><br>

</center>
</div>

</body>

</html>


