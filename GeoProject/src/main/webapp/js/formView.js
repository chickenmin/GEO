$(document).ready(function() {
    $('#savePdf').click(function() {
        setTimeout(function() {
            var pdfWidth = 210; // A4 너비 mm
            var pdfHeight = 297; // A4 높이 mm

            html2canvas($('#pdfDiv')[0], {
                scale: 2, // 해상도 2배로 설정
                useCORS: true,
                scrollX: 0, // 스크롤된 부분 없이 고정된 영역만 캡처
                scrollY: 0,
                x: $('#pdfDiv').offset().left, // 요소의 위치를 정확하게 캡처
                y: $('#pdfDiv').offset().top, 
                width: $('#pdfDiv').outerWidth(), // 요소 너비
                height: $('#pdfDiv').outerHeight() // 요소 높이
            }).then(function(canvas) {
                var imgData = canvas.toDataURL('image/png');
                var imgWidth = pdfWidth; // PDF 너비 설정
                var imgHeight = canvas.height * pdfWidth / canvas.width; // 비율에 맞춘 이미지 높이
                var heightLeft = imgHeight;
                var doc = new jsPDF('p', 'mm', 'a4'); // PDF 세로 방향

                var position = 0; // 첫 페이지에 출력할 위치

                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);

                heightLeft -= pdfHeight;

                // 페이지가 여러 장일 경우 처리
//                while (heightLeft >= 0) {
                    position = heightLeft - imgHeight;
//                    doc.addPage();
                    doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                    heightLeft -= pdfHeight;
//                }

                doc.save('document.pdf');
            }).catch(function(error) {
                console.error("Error generating canvas: ", error);
            });
        }, 1000); // 1초 지연
    });
});
