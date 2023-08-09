<%--
  Created by IntelliJ IDEA.
  User: db400tea
  Date: 2023-08-09
  Time: 오후 3:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "select * from faq order by fno";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    List<Faq> faqlist = new ArrayList<>();
    while(rs.next()){
        Faq faq = new Faq();
        faq.setFno(rs.getInt("fno"));
        faq.setQuestion(rs.getString("question"));
        faq.setAnswer(rs.getString("answer"));
        faq.setCnt(rs.getInt("cnt"));
        faqlist.add(faq);
    }
    con.close(rs, pstmt, conn);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자주 묻는 질문</title>

    <%@ include file="../head.jsp" %>
    <!-- 스타일 초기화 : reset.css 또는 normalize.css -->
    <link href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css" rel="stylesheet">

    <!-- 필요한 폰트를 로딩 : 구글 웹 폰트에서 폰트를 선택하여 해당 내용을 붙여 넣기 -->
    <link rel="stylesheet" href="../google.css">
    <link rel="stylesheet" href="../fonts.css">

    <!-- 필요한 플러그인 연결 -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link rel="stylesheet" href="../common.css">
    <link rel="stylesheet" href="../hd.css">

    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; min-height:100vh;
            background-image: url("bg_visual_overview.jpg");
            background-repeat: no-repeat; background-position:center -250px; }
        .contents::after { content:""; clear:both; display:block; width:100%; }

        .page { clear:both; width: 100vw; height: 100vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center; padding-top:1em; color:#fff;
            padding-bottom: 2.4rem; }

        .breadcrumb { clear:both;
            width:1200px; margin: 0 auto; text-align: right; color:#fff;
            padding-top: 28px; padding-bottom: 28px; }
        .breadcrumb a { color:#fff; }
        .frm { clear:both; width:1200px; margin:0 auto; padding-top: 80px; }

        .tb1 { width:800px; margin:50px auto; }
        .tb1 th { line-height:32px; padding-top:8px; padding-bottom:8px;
            border-top:1px solid #333; border-bottom:1px solid #333;
            background-color:yellowgreen; color:#fff; }
        .tb1 td {line-height:32px; padding-top:8px; padding-bottom:8px;
            border-bottom:1px solid #333;
            padding-left: 14px; border-top:1px solid #333; }

        .indata { display:inline-block; width:300px; height: 48px; line-height: 48px;
            text-indent:14px; font-size:18px; }
        .inbtn { display:block;  border-radius:100px;
            min-width:140px; padding-left: 24px; padding-right: 24px; text-align: center;
            line-height: 48px; background-color: #333; color:#fff; font-size: 18px; }
        .inbtn:first-child { float:left; }
        .inbtn:last-child { float:right; }

        .ans {display: none;}
    </style>

    <link rel="stylesheet" href="../ft.css">
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp"%>
    </header>
    <div class="contents">
        <div class="breadcrumb">
            <p>
                <a href="/">HOME</a> &gt;
                <a href="">Faq</a> &gt;
                <span>자주 묻는 질문</span>
            </p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">자주 묻는 질문</h2>
                <br><br><hr><br><br>
                <ul class="faqlist">
                    <%
                        for (Faq faq : faqlist) {
                    %>
                    <li>
                        <div class="que"><%=faq.getQuestion()%></div>
                        <div class="ans"><%=faq.getAnswer()%></div>
                    </li>
                    <%
                        }
                    %>
                    <hr>
                </ul>
            </div>
            <script>
                $(document).ready(function (){
                    $(".faqlist li").click(function (){
                        $(this).find(".ans").slideToggle(500);
                    });
                });
            </script>
            <div class="btn_group">
                <% if (sid!= null && sid.equals("admin")) { %>
                <a href="/faq/addFaq.jsp" class="inbtn">글쓰기</a>
                <% } else {%>
                <p>관리자만 자주하는 질문의 글을 쓸 수 있습니다.</p>
                <% } %>
            </div>
            <footer class="ft" id="ft">
                <%@ include file="../footer.jsp"%>
            </footer>
        </section>
    </div>
</div>
</body>
</html>