/* --------------------------------------------------- */
/*			  		StringBuffer					   */
/* --------------------------------------------------- */
function StringBuffer() {
	this.content = new Array;
} 
StringBuffer.prototype = {
	append: function(val) { 
		this.content.push(val);
	},
	length: function() {
		return this.content.length;
	},
	toString: function(val) {
		if(typeof val == 'undefined') val = '';		
		return this.content.join(val);
	}
}

/* --------------------------------------------------- */
/*			  Number prototype 함수 정의			   */
/* --------------------------------------------------- */
Number.prototype.setBlank = function() {
	return this.toString().setBlank();
}

Number.prototype.setComma = function() {
	return this.toString().setComma();
}

Number.prototype.setdotComma = function() {
	return this.toString().setdotComma(num);
}

Number.prototype.removeComma = function() {
	return this.toString().removeComma();
}

Number.prototype.Numeric2Won = function(){
	return this.toString().Numeric2Won();
}

Number.prototype.str2date = function() {
	return this.toString().str2date();
}

Number.prototype.setNumberDate = function() {
	return this.toString().setNumberDate();
}

Number.prototype.setNumberTime = function() {
	return this.toString().setNumberTime();
}

Number.prototype.setNumberPercent = function() {
	return this.toString().setNumberPercent();
}

Number.prototype.setNumberSSN = function(type) {
	return this.toString().setNumberSSN(type);
}
	
Number.prototype.setNumberPhone = function(type) {
	return this.toString().setNumberPhone(type);
}

Number.prototype.setFileSize = function() {
	return this.toString().setFileSize();
}

Number.prototype.bytes = function() {
	return this.toString().bytes();
}

Number.prototype.truncate = function(length) {
	return this.toString().truncate(length);
}

/* --------------------------------------------------- */
/*			  String prototype 함수 정의			   */
/* --------------------------------------------------- */
String.prototype.replaceAll = function(val, replVal) {
	var reg = new RegExp(val, "g");
	return this.replace(reg, replVal);
};

String.prototype.addslashes = function() { // 특수문자 앞에 \ 추가
	var str = this.toString();
	return str.replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0');
}

String.prototype.stripslashes = function() { // 특수문자앞의 \ 제거
	var str = this.toString();
	return str.replace(/\\(.?)/g, function (s, n1) {
		switch (n1) {
			case '\\':
				return '\\';
			case '0':
				return '\u0000';
			case '':
				return '';
			default:
				return n1;
		}
	});
}

String.prototype.trim = function() { // 양쪽여백 제거
	var str = this.toString();
	return this.replace(/^\|\s|$/g, '');
}

String.prototype.rtrim = function() { // 오른쪽여백 제거
	var str = this.toString();
	return this.replace(/^\s+/, '');
}

String.prototype.ltrim = function() { // 왼쪽여백 제거
	var str = this.toString();
	return this.replace(/\s+$/, '');
}

String.prototype.nl2br = function() { // 케리지리턴을 BR 태그로 변경
	var str = this.toString();
	str = str.replace(/\r\n/gi, '<br />');
	str = str.replace(/\n\r/gi, '<br />');
	str = str.replace(/\n/gi, '<br />');
	return str;
}

String.prototype.nl2blank = function() { // 케리지리턴을 공백으로 변경
	var str = this.toString();
	str = str.replace(/\r\n/gi, '');
	str = str.replace(/\n\r/gi, '');
	str = str.replace(/\r/gi, '');
	str = str.replace(/\n/gi, '');
	return str;
}

String.prototype.setBlank = function() { // 빈문자: html &nbsp;
	var str = this.toString().trim();
	return (str == '') ? '&nbsp;' : str;
}

String.prototype.setComma = function() { // 콤마 찍기
	
	var str = this.toString();	
	if( -1 == str.indexOf('-') )
	{
		
		str = str.replace(/\D/g, '');
		
		var temp = str.toString();
		temp = temp.replace(/\D/g, '');
		str = parseFloat(str.replace(/,|\s/g,''));
		if(isNaN(str)) {
			return temp;
		} else if(str == 0) {
			return str;
		} else {
			var reg = /(^[-]?\d+)(\d{3})/;
			str += '';
			while(reg.test(str)) str = str.replace(reg, '$1'+','+'$2');
			return str;
		}
		
	} else 
	{
		
		var str_minus = str.split('-');	
		str = str_minus[1];	
		
		var str = this.toString();	
		str = str.replace(/\D/g, '');
		
		var temp = str.toString();
		temp = temp.replace(/\D/g, '');
		str = parseFloat(str.replace(/,|\s/g,''));
		if(isNaN(str)) {
			return '-'+temp;
		} else if(str == 0) {
			return str;
		} else {
			var reg = /(^[-]?\d+)(\d{3})/;
			str += '';
			while(reg.test(str)) str = str.replace(reg, '$1'+','+'$2');
			return '-'+str;
		}
		
	}
	
}

String.prototype.removeComma = function() { // 콤마 없애기
	var str = this.toString();
	return str.replace(/,|\s/g,'');
}

String.prototype.setdotComma = function(num) { // 콤마 찍기
	
	var str = this.toString();
	
	if( -1 == str.indexOf('.') ){ 
	
		str = str.replace(/\D/g, ''); 	
		
		var temp = str.toString();
		temp = temp.replace(/\D/g, '');
		str = parseFloat(str.replace(/,|\s/g,''));
		if(isNaN(str)) {
			return temp;
		} else if(str == 0) {
			return str;
		} else {
			var reg = /(^[-]?\d+)(\d{3})/;
			str += '';
			while(reg.test(str)) str = str.replace(reg, '$1'+','+'$2');
			return str;
		}
		
	} 
	else { 
		
		var str_dot = str.split('.');	
		str_f = str_dot[0];	
		str_r = str_dot[1];	
		
		var temp_f = str_f.toString();
		temp_f = temp_f.replace(/\D/g, '');
		str_f = parseFloat(str_f.replace(/,|\s/g,''));
		
		var temp_r = str_r.toString();
		temp_r = temp_r.replace(/\D/g, '');
		//str_r = parseFloat(str_r.replace(/,|\s/g,''));
		str_r = str_r.replace(/,|\s/g,'');
		
		if(isNaN(str_f) || isNaN(str_r)) {
			var reg = /(^[-]?\d+)(\d{3})/;
			temp_f += '';
			while(reg.test(temp_f)) temp_f = temp_f.replace(reg, '$1'+','+'$2');
			if(temp_r.length > 3){ temp_r = temp_r.substr(0,num); }
			temp_f += '.'+temp_r;
			return temp_f;
		} else if(str_f == 0) {
			if(temp_r.length > 3){ temp_r = temp_r.substr(0,num); }
			return '0.'+temp_r;
		} else {
			var reg = /(^[-]?\d+)(\d{3})/;
			str_f += '';
			while(reg.test(str_f)) str_f = str_f.replace(reg, '$1'+','+'$2');
			if(str_r.length > 3){ str_r = str_r.substr(0,num); }
			str_f += '.'+str_r;
			return str_f;
		}
		
	}
	
}

// 숫자를 문자형태로 변형
String.prototype.Numeric2Won = function(){
	var price = this.toString();
	n = price.replace(/-|,|\s/g,'');
	if(isNaN(n)) n = 0;
	n += '';
	if(n.substr(0,1)==0) {return '영';}
	var price_unit0=new Array('','일','이','삼','사','오','육','칠','팔','구');
	var price_unit1=new Array('','십','백','천');
	var price_unit2=new Array('만','억','조','경','해');
	var won=new Array;
	for(i=0;i<=n.length-1;i++){won[i]=price_unit0[n.substr(i,1)];}
	won=won.reverse();
	for(i=0;i<=n.length-1;i++){if(i>0 && won[i]!='') {won[i]+=price_unit1[i%4];}}
	for(i=4;i<=won.length-1;i=i+4) {won[i]+=price_unit2[(i/4-1)];}
	for(i=0;i<=n.length-1;i++){if(i%4 > 0) {won[i]=won[i].replace('일','');}}
	won=won.reverse();
	return won.join('');
}

// 문자를 날짜형태로
String.prototype.str2date = function() {
	var str = this.toString();
	return str.substr(0,4)+'.'+str.substr(4,2)+'.'+str.substr(6,2);
}

// 숫자를 제외한 나머지 문자 제거
String.prototype.setNumber = function() {
	var str = this.toString();
	return str.replace(/\D/g,'');
}

// % 너주기
String.prototype.setNumberPercent = function() {
	var str = this.toString();
	str = parseFloat(str.replace(/\D/g, ''));
	if(isNaN(str)) str = 0;
	else if(str > 100) str = 100;
	else if(str == "") str = 0;
	return str+' %';
}

// 날짜 자동하이픈
String.prototype.setNumberDate = function() {
	var str = this.toString();
	str = str.replace(/\D/g, '');
	if(str.length > 8) str = str.substr(0,8); 
	if(str.length > 6) str = str.substr(0,4) + '-' + str.substr(4,2) + '-' + str.substr(6);
	else if(str.length > 4) str = str.substr(0,4) + '-' + str.substr(4);
	return str;
}
/*
// 시간 자동콜로미
String.prototype.setNumberTime = function() {
	var str = this.toString();
	str = str.replace(/\D/g, '');
	
	if(str.length > 4)
	{
		str = String(parseInt(str));
		
		if(str > 2400)
		{
			str = "24:00";
		}
		else if(str.length > 3)
		{
			str2 = str.substr(0,2);
			if(str.substr(2,2) > 59)
			{
				str2+= ':00';
			}else{
				str2+= ':' + str.substr(2,2);
			}
			str = str2;
		}
		else if(str.length > 2)
		{
			str = '0'+str.substr(0,1) + ':' + str.substr(1,2);
			
		}else if(str >= 10){
			str = '00:' + str;
		}else{
			str = '00:0' + str;
		}
	}
	else if(str.length > 3)
	{
		
		if(str.substr(0,2) > 24) str2 = 24;
		else str2 = str.substr(0,2);
		
		if(str.substr(2,2) > 59) str2+= ":00";
		else str2+= ":"+str.substr(2,2);
		
		str = str2;
	}
	else if(str.length > 2)
	{
		
		str2 = "0"+str.substr(0,1);
		
		if(str.substr(1,2) > 59) str2+= ":00";
		else str2+= ":"+str.substr(1,2);
		str = str2;
	}
	
	return str;
}
*/
// 시간 자동콜로미
String.prototype.setNumberTime = function() {
	var str = this.toString();
	str = str.replace(/\D/g, '');
	
	str = String(parseInt(str));

	if(isNaN(str)) str = '00:00';
	else if(str.length > 3) str = str.substr(0,2) + ':' + str.substr(2,2);
	else str = '0' + str.substr(0,1) + ':' + str.substr(1,2);
	
	
	
	return str;
}
// 주민번호, 사업자번호 자동하이픈
String.prototype.setNumberSSN = function(type) {
	var str = this.toString();
	str = str.replace(/\D/g, '');
	if(str == '') return;
	if(typeof type == 'undefined') {
		if(str.length > 13) str = str.substr(0,13); 
		if(str.length > 6) str = str.substr(0,6) + '-' + str.substr(6);
	} else {
		if(str.length > 10) str = str.substr(0,10);
		if(str.length > 5) str = str.substr(0,3) + '-' + str.substr(3,2) + '-' + str.substr(5);
		else if(str.length > 3) str = str.substr(0,3) + '-' + str.substr(3);
	}
	return str;
}

// 휴대폰번호, 전화번호 자동하이픈
String.prototype.setNumberPhone = function(type) {
	var str = this.toString();
	str = str.replace(/\D/g, '');
	if(str == '') return;
	if(typeof type == 'undefined') {
		if(str.substr(0,1) == '0') { // 휴대폰번호
			if(str.length > 12) str = str.substr(0,12);
			if(str.length > 11) str = str.substr(0,4) + '-' + str.substr(4, 4) + '-' + str.substr(8);
			else if(str.length > 10) str = str.substr(0,3) + '-' + str.substr(3, 4) + '-' + str.substr(7);
			else if(str.length > 6) str = str.substr(0,3) + '-' + str.substr(3, 3) + '-' + str.substr(6);
			else if(str.length > 3) str = str.substr(0,3) + '-' + str.substr(3);
		} else { // 1588 등으로 시작하는 번호
			if(str.length > 8) str = str.substr(0,8);
			if(str.length > 4) str = str.substr(0,4) + '-' + str.substr(4);
		}
	} else {
		if(str.substr(0,2) == '02') { // 서울전화번호
			if(str.length > 10) str = str.substr(0,10);
			if(str.length > 9) str = str.substr(0,2) + '-' + str.substr(2,4) + '-' + str.substr(6);
			else if(str.length > 5) str = str.substr(0,2) + '-' + str.substr(2,3) + '-' + str.substr(5);
			else if(str.length > 2) str = str.substr(0,2) + '-' + str.substr(2);
		} else if(str.substr(0,4) == '0502' || str.substr(0,4) == '0505') {
			if(str.length > 12) str = str.substr(0,12);
			if(str.length > 11) str = str.substr(0,4) + '-' + str.substr(4,4) + '-' + str.substr(8);
			else if(str.length > 7) str = str.substr(0,4) + '-' + str.substr(4,3) + '-' + str.substr(7);
			else if(str.length > 4) str = str.substr(0,4) + '-' + str.substr(4);
		} else if(str.substr(0,1) == '1') {
			if(str.length > 8) str = str.substr(0,4) + '-' + str.substr(4,4) + '-' + str.substr(8);
			else if(str.length > 4) str = str.substr(0,4) + '-' + str.substr(4);
		} else {
			if(str.length > 11) str = str.substr(0,11);
			if(str.length > 10) str = str.substr(0,3) + '-' + str.substr(3,4) + '-' + str.substr(7);
			else if(str.length > 6) str = str.substr(0,3) + '-' + str.substr(3,3) + '-' + str.substr(6);
			else if(str.length > 3) str = str.substr(0,3) + '-' + str.substr(3);
		}
	}
	return str;
}

String.prototype.setFileSize = function(fixed) {
	if(typeof fixed == 'undefined') fixed = 2;
	var str = Number(this.toString().setNumber());
	if(str >= 1073741824) {
		str = (str / 1073741824).toFixed(fixed) + 'G';
	} else if(str >= 1048576) {
		str = (str / 1048576).toFixed(fixed) + 'M';
	} else if(str >= 1024) {
		str = (str / 1024).toFixed(fixed) + 'K';
	} else {
		str = str + 'byte';
	}
	return str;
}

String.prototype.bytes = function() {
	var str = this.toString();
	var count = 0;
	var i = 0;
	for(i=0; i<str.length; i++) count += (str.charCodeAt(i) > 128) ? 2 : 1;
	return count;
}

String.prototype.truncate = function(length) {
	var str = this.toString();
	if(typeof length == 'undefined') return str;
	var count = 0;
	var i = 0;
	for(i=0; i<str.length; i++) {
		count += (str.charCodeAt(i) > 128) ? 2 : 1;
		if(count > length) return str.substring(0, i);
	}
	return str;
}

/**
 * common grid validation
**/
 
//grid NumberFormat 소수점 자리 수 포맷팅
var getGridNumberFormat = function(pointLen){
	var format = "";
	if(isNaN(pointLen) || pointLen > 5){
		format =  "0,000";
	} else
	{
		var point = 0.000000000.toFixed(pointLen);
		format = "0,00" + point.toString();
	}	
	return format;
}