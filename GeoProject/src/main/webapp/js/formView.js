$(document).ready(function() {
    $('#savePdf').click(function() {
        setTimeout(function() { // 일정 시간 후 PDF 생성
            html2canvas($('#pdfDiv')[0], {
                scale: 2,
                useCORS: true
            }).then(function(canvas) {
                var imgData = canvas.toDataURL('image/png');
                var imgWidth = 210;
                var pageHeight = 297;
                var imgHeight = canvas.height * imgWidth / canvas.width;
                var heightLeft = imgHeight;
                var doc = new jsPDF('p', 'mm', 'a4');
                var position = 0;

                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;

                while (heightLeft >= 0) {
                    position = heightLeft - imgHeight;
                    doc.addPage();
                    doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                    heightLeft -= pageHeight;
                }

                doc.save('document.pdf');
            }).catch(function(error) {
                console.error("Error generating canvas: ", error);
            });
        }, 1000); // 1초 지연
    });
});
