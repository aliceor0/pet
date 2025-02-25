<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src='https://code.jquery.com/jquery-latest.js'></script>
<title>유기동물 상세정보</title>
</head>
    <style>
        td, th { 
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
            font-size: 16px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        img {
            max-width: 100%;
            height: auto;
        }
        .mayor {
            border: none;
            background-color: transparent;
            font-weight: bold;
            font-size: 1.2em;
            text-align : right;
        }
        a {
            font-size: 0.8em;
            color: #007bff;
        }
    </style>
<body>
    <p>「동물보호법」 제17조, 같은 법 시행령 제7조 및 같은 법 시행규칙 제20조에 따라 구조된 동물의 보호상황을 아래와 같이 공고합니다.</p>
    <br>

    <div>
        <div id="query-params-container"></div>
    </div>

    <br><br>

    <div>
        <p> 상기 동물을 분실하신 소유주께서는 보호센터로 문의하시어 동물을 찾아가시기 바라며, 동물보호 법 제17조의 규정에 따른 공고가 있는 날부터 10일이 경과하여도 소유자 등을 알 수 없는 경우에는 유실물법 제12조 및 민법 제253조의 규정에 불구하고 해당 시,군,구 자치구가 그 동물의 소유권을 취득하게 됩니다.</p>
        <br><br>
        <input type="text" class="mayor">(직인생략)
        <br><br>
    </div>

    <a>※ 해당 글은 동물보호관리시스템을 참조한 것입니다</a>

    <script>
        window.onload = function() {
            let params = new URLSearchParams(window.location.search);
            let queryParams = {};

            for (let [key, value] of params) {
                queryParams[key] = value;
            }

            let orgNm = queryParams['orgNm'];
            if (orgNm) {
                let mayor = "";

                if (orgNm.includes("시")) {
                    mayor = orgNm.split("시")[0];
                } else if (orgNm.includes("군")) {
                    mayor = orgNm.split("군")[0];
                } else if (orgNm.includes("구")) {
                    mayor = orgNm.split("구")[0];
                }

                $('.mayor').val(mayor + '장');
            }
                        
            let container = $("#query-params-container");
			
            let table = $("<table>");
            let tbody = $("<tbody>");

            let keys = Object.keys(queryParams);
            let halfLength = Math.ceil(keys.length / 2);
			
            // 사진 추가
            let trImg = $("<tr>");
            let thImg = $("<th>").text('사진');
            let tdImg = $("<td>").attr('colspan', '3').append($("<img>").attr('src', queryParams['popfile']));
            trImg.append(thImg).append(tdImg);
            tbody.append(trImg);

            for (let i = 0; i < halfLength; i++) {
                let tr = $("<tr>");
                let thKey1 = $("<th>").text(keyTranslate(keys[i]));
                let tdValue1 = $("<td>").text(queryParams[keys[i]]);

                let thKey2 = $("<th>").text(keyTranslate(keys[i + halfLength]));
                let tdValue2 = $("<td>").text(queryParams[keys[i + halfLength]]);

                tr.append(thKey1).append(tdValue1).append(thKey2).append(tdValue2);
                tbody.append(tr);
            }

            table.append(tbody);
            container.append(table);
        };

        function keyTranslate(key) {
            const translations = {
                'popfile': '사진',
                'happenDt': '접수일시',
                'happenPlace': '발생장소',
                'kindCd': '품종',
                'colorCd': '색상',
                'age': '나이',
                'weight': '무게',
                'noticeNo': '공고번호',
                'noticeSdt': '공고기한 시작일',
                'noticeEdt': '공고기한 마감',
                'processState': '상태',
                'sexCd': '성별',
                'neuterYn': '중성화여부',
                'specialMark': '특이사항',
                'careNm': '보호센터',
                'careTel': '전화번호',
                'careAddr': '주소',
                'orgNm': '관할기관',
                'chargeNm': '담당자',
                'officetel': '연락처'
            };
            return translations[key] || key;
        }
    </script>
</body>
</html>