<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

    ul li {
        list-style: none;
    }

    a {
        text-decoration: none;
    }

    .category {
        width: 800px;
        height: 50px;
        line-height: 50px;
        margin: 0 auto;
        text-align: center;
    }

    .category>ul>li {
        float: left;
        width: 140px;
        position: relative;
    }

    .category>ul>li:hover>ul {
        display: block;
    }

    .category>ul>li>ul {
        width: 130px;
        display: none;
        position: absolute;
        font-size: 14px;
        background: skyblue;
        z-index: 2;
    }

    .category>ul>li>ul {
        display: none;
        font-size: 14px;
    }
    /* 카테고리 기본메뉴가 안보이게하는css */
    .category>ul>li:hover>ul {
        display: block;
    }
    /* 카테고리 마우스오버시 보이게하는css */
</style>

<div class="category">
    <ul>
        <li><a href="#">MENU1</a>
            <ul>
                <li><a href="#">SUB_MENU</a></li>
                <li><a href="#">SUB_MENU2</a></li>
                <li><a href="#">SUB_MENU3</a></li>
            </ul>
        </li>
        <li><a href="#">MENU2</a>
            <ul>
                <li><a href="#">SUB_MENU</a></li>
                <li><a href="#">SUB_MENU2</a></li>
                <li><a href="#">SUB_MENU3</a></li>
            </ul>
        </li>
        <li><a href="#">MENU3</a>
            <ul>
                <li><a href="#">SUB_MENU</a></li>
                <li><a href="#">SUB_MENU2</a></li>
                <li><a href="#">SUB_MENU3</a></li>
            </ul>
        </li>
        <li><a href="#">MENU4</a>
            <ul>
                <li><a href="#">SUB_MENU</a></li>
                <li><a href="#">SUB_MENU2</a></li>
                <li><a href="#">SUB_MENU3</a></li>
            </ul>
        </li>
        <li><a href="#">MENU5</a>
            <ul>
                <li><a href="#">SUB_MENU</a></li>
                <li><a href="#">SUB_MENU2</a></li>
                <li><a href="#">SUB_MENU3</a></li>
            </ul>
        </li>
    </ul>
</div>