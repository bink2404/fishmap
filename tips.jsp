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

<title>myfishingmaps - Comments</title>

<meta name="keywords" content="fishing, fish, cast, bait, lure, pike, carp, bass">
<meta name="description" content="myfishingmaps">

</head>

<body bgcolor=white>

<% 
	String url = "jdbc:mysql://localhost/fantas15_dbsql";

	String locationId = request.getParameter("location") ;
	ResultSet rs, rs1 ;
	String query ;
	String comment ;
	String dateTime ;
	String author ;
	StringBuffer writeText = new StringBuffer() ;
	int i, j ;
	String locationName ;

	try
	{
		Class.forName("org.gjt.mm.mysql.Driver") ;
		
		Connection con = DriverManager.getConnection(url, "fantas15_fsn2404", "doosie");

		java.sql.Statement stmt = con.createStatement();
		java.sql.Statement stmt1 = con.createStatement();

		query = "SELECT locationName FROM fm_locations WHERE locationId = " + locationId ;

		rs = stmt.executeQuery(query);

		rs.next() ;

		locationName = rs.getString("locationName") ;

		out.println("<center><b>Comments for " + locationName + "</b>") ;

		out.println("<br><br><A HREF=\"postComment.jsp?locationId=" + locationId + "\">Post a comment</A>") ;

		out.println("<br><br><table border=\"0\" width=\"65%\" height=\"1\" cellpadding=\"2\">") ;

		// Show existing comments
		query = "SELECT comment, author, dateTime FROM fm_comments WHERE locationId = " + locationId ;

		rs1 = stmt1.executeQuery(query);

		while (rs1.next())
		{
			comment = rs1.getString("comment") ;
			author = rs1.getString("author") ;
			dateTime = rs1.getString("dateTime") ;

			out.println("<tr>") ;

			out.println("<b>Posted on " + dateTime + " by " + author + "</b><br>") ;

			writeText.setLength(0) ;

			// Replace any newline chars with a linebreak
			for (i = 0 ; i < comment.length() ; i++)
			{
				if (comment.charAt(i) == '\n')
				{
					writeText.append("<br>") ;
				}
				else
				{
					writeText.append(comment.charAt(i)) ;
				}
			}

			out.println(writeText) ;
			out.println("</font></td></tr><br>") ;
		}

		out.println("</table>") ;

		con.close() ;
	}
	catch (Exception e)
	{
		out.println("Problem reading the database<br>") ;
		out.println(e) ;
	}
%>

</center>
</div>

</body>

</html>


