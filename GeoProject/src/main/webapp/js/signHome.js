$(document).ready(function() {
    // 캔버스 요소와 SignaturePad 초기화
    const canvas = document.getElementById('signature-pad');
    const signaturePad = new SignaturePad(canvas, {
        backgroundColor: 'rgba(255, 255, 255, 0)', // 투명 배경
        penColor: 'black' // 펜 색상
    });

    // 캔버스 크기 조절 (반응형 지원)
    function resizeCanvas() {
        const ratio = Math.max(window.devicePixelRatio || 1, 1);
        canvas.width = canvas.offsetWidth * ratio;
        canvas.height = canvas.offsetHeight * ratio;

        // 서명이 흐릿해지지 않도록 스케일 설정
        canvas.getContext('2d').scale(ratio, ratio);

        // 캔버스 크기 변경 시 서명을 지우기 위해 초기화
        signaturePad.clear();
    }

    // 윈도우 크기 조정 시 캔버스 크기 재조정
    window.addEventListener('resize', resizeCanvas);
    resizeCanvas(); // 페이지 로드 시 초기 크기 설정

    // 폼 제출 처리
    var frm = document.getElementById("signForm");
    var submitBtns = document.getElementById("submitSign");

    submitBtns.onclick = function(event) {
        event.preventDefault();
        
        // 서명이 비어 있는지 확인
        if (signaturePad.isEmpty()) {
            alert('서명이 비어 있습니다.');
            return;
        }

        // 서명을 이미지 데이터로 변환하고 hidden input에 설정
        const dataURL = signaturePad.toDataURL('image/png');
        document.getElementById('signatureImageInput').value = dataURL.replace(/^data:image\/png;base64,/, '');;

        // 폼 제출
        frm.submit();
    }

    // 초기화 버튼 클릭 시 서명 초기화
    document.getElementById('clear').addEventListener('click', function() {
        signaturePad.clear();
    });

    // 모달이 열릴 때 캔버스 크기 조정
    $('#enroll').on('shown.bs.modal', function () {
        resizeCanvas(); // 모달이 열릴 때 캔버스 크기 조정
    });
});
