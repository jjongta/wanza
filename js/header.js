
includeHTML();

// 상단 배너 X 클릭 삭제
$(document).on('click', '#closeBanner', function() {
    $('#_card').hide();
})

// 로고 클릭 -> 메인화면 이동
$(document).on('click', '#_logo', function () {
    location.href = '../../index.html';
})

$(document).on('click', '#goCart', function () {
    location.href = "../store/cart.html";
})

$(document).on('attr', '#headerSearch', function () {
    location.href = "../login/login.html"
})
// 검색 아이콘 클릭시 검색어 DB저장
$(document).on('click', '#search-icon', function () {

    let searchVal = $("#headerSearch").val().trim();
    //let encoded = encodeURI(searchVal);
    let resultStr = XSSCheck(searchVal, 0);
    
    
    if(slangFilter(searchVal)) {
        alert('비속어가 포함되어 있습니다.');
        return;
    }
    // 검색어가 없는경우 placeholder값으로 입력
    if(searchVal==""){
        document.getElementById("headerSearch").setAttribute("value",$("#headerSearch").attr('placeholder'))
    }
    else{
        $.ajax({
            url:"http://localhost:3000/searchWrite",
            type:"get",
            data:{searchWord:String(searchVal)},
            success:function(data) {
                if(data=="suc"){ console.log("검색어등록성공"); }
                else           { console.log("검색어등록실패"); }
            },
            error:function(){ console.log("검색error"); }
        });
        location.href = "../commons/search.html?searchWord="+resultStr
    }

    
});





$(document).ready(function() {
    // 세션 아이디 정보 가져오기
    let sessionId = sessionStorage.getItem("login");
    console.log(sessionId)
    if (sessionId != null) {
        let auth = JSON.parse(sessionId).auth
        if(auth==3){
            let admin = '<i class="fas fa-file-signature"></i> 관리자페이지'
            $('#myp').html(admin)
            $('#myp').attr('onclick', 'location.href="../admin/mainAdmin.html"')
            $('.cart').remove()
            $('#goLogin').html('<b>관리자 </b> <i class="fa fa-sort-down"></i>');
        }
        else if(auth == 7) {
            alert('경고 3번 누적으로 인해 계정이 정지되었습니다.');
            sessionStorage.removeItem('login');
            location.href = '../../index.html';
            return;
            
        }        
        else{
            $('#goLogin').html('<b>내 정보 </b> <i class="fa fa-sort-down"></i>');
        }
        $('#goLogin').addClass('active')
        $(document).on('click', '#goLogin', function () {
            location.href = "../myPage/mainMyPage.html"
        });
    }else{
        $('#goLogin').removeClass('active')
        $(document).on('click', '#goLogin', function () {
            location.href = "../login/login.html"
        });
    }
    $(document).on('click', '#logOut', function () {
        sessionStorage.removeItem('login');
        location.href = '../../index.html';
    });

    // 실시간 검색어 슬라이드
    function tick() {
        $('#_realTime li:first').slideUp(function () {
            $(this).appendTo($('#_realTime')).slideDown();
        })
    };

    // 실시간 검색어 2초마다 변경
    setInterval(function () {tick()}, 2000);




    // 이벤트 검색어 랜덤 추출
    let eventSearchText = new Array(
        '여름 특별 세일', '모션데스크&책장 함께 드려요',
        '슬기로운 집콕생활', '데스커 모션데스크')
    function randomItem(item) {
        return item[Math.floor(Math.random() * item.length)];
    };
    let choiceText = randomItem(eventSearchText);
    //console.log(choiceText);
    document.getElementById('headerSearch').setAttribute('placeholder', choiceText);
    
    // 실시간 검색순위 리스트
    getSearchList();
    function getSearchList(){
        $.ajax({
            url:"http://192.168.0.231:3000/getSearchWord",
            type:"get",
            success:function(list){
                
                let app="";
                let app2="";

                let today = new Date()
                let year = today.getFullYear()   // 년
                let month = today.getMonth()+1   // 월
                let date = today.getDate();      // 날짜
                let hours = today.getHours();    // 시
                let minutes = today.getMinutes();  // 분

                if(hours<10){
                    hours = "0"+hours;
                }

                if(minutes<10){
                    minutes = "0"+minutes;
                }

                app2 ="<div id='searchChart'>"
                    +"<table id='searchTable'>"
                    +"<colgroup>"
                    +"<col width='160px'><col width='160px'>"
                    +"</colgroup>"
                    +"<tr>"
                    +"<th>실시간 인기 검색어</th>"
                    +"<td style='color:#757575; font-size:14px; text-align:right;'>"+year+"."+month+"."+date+" "+hours+":"+minutes+" 기준"+"</td>"
                    +"</tr>"

                $.each(list,function(i,val){                 
                    app += "<li><b>"+(i+1)+"</b> &emsp;<a href='../commons/search.html?searchWord="+val.searchWord+"' style='color: black;'>"+val.searchWord+"</a></li>";
                    app2 += "<tr>"
                        +"<td colspan='2' style='margin-left:3px'><a href='../commons/search.html?searchWord="+val.searchWord+"' style='color:black'><b style='color:#F18260'>"+(i+1)+". </b> "+val.searchWord+"</a></td>"
                        +"</tr>";

                });
                //console.log(app)
                $("#_realTime").append(app);
                app2 +="<tr>"
                    +"<td id='closeSearch' colspan='2' style='text-align:center; cursor: pointer; color:#757575; font-size:13px' >닫기</td>"
                    +"</tr>" 
                     +"</table>"
                     +"</div>";
                $("#hotIssue").after(app2);
                //console.log(app)
                
            },
            error:function(){
                //alert('검색순위 error')
            }
        })
    }


    $(document).on('click','#_realTime',function(){
        $("#searchChart").slideDown();
    })

    $(document).on('click','#closeSearch',function(){ 
        $("#searchChart").slideUp();
    });

    // 탑 버튼
    var btn = $('#backToTop');
    let ftop;
    $(document).ajaxComplete(function() {
        ftop = $('footer').offset().top;
    });
        
    $(window).scroll(function() {
        if ($(window).scrollTop() > 300) {
            btn.addClass('show');
        }else{
            btn.removeClass('show');
        }
        if (btn.offset().top > ftop-3) {
            btn.addClass('change');
        }else{
            btn.removeClass('change');
        }
    });
        
    btn.on('click', function(e) {
        e.preventDefault();
        $('html, body').scrollTop(0);
    });


});


function XSSCheck(str, level) {
    if(str.includes('[') || str.includes(']')) {
        str = str.replace(/\[/g, "");
        str = str.replace(/\]/g, "");
    }
    if (level == undefined || level == 0) {
        str = str.replace(/\<|\>|\"|\'|\%|\;|\(|\)|\&|\+|\-/g,"");
    } else if (level != undefined && level == 1) {
        str = str.replace(/\</g, "&lt;");
        str = str.replace(/\>/g, "&gt;");
    }
    return str;
}
