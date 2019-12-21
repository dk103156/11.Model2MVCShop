<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>ī�װ��� ��� �˻��ϱ�</title>
    
</head>
<body>

<input type="text" id="sample5_address" placeholder="�ּ�" style="width: 497px;">
<input type="button" onclick="sample5_execDaumPostcode()" value="�ּ� �˻�"><br>
<input type="text" id="sample5_address" placeholder="���ּ��Է�" style="width: 497px;">
<div id="map" style="width:500px;height:500px;margin-top:10px;display:none"></div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=23f42ad0e8f45f562e0f2a2d770c3784&libraries=services"></script>

<script>
var mapContainer = document.getElementById('map'), // ������ ǥ���� div
mapOption = {
	center: new daum.maps.LatLng(37.537187, 127.005476), // ������ �߽���ǥ
	level: 5 // ������ Ȯ�� ����
};

//������ �̸� ����
var map = new daum.maps.Map(mapContainer, mapOption);

//�ּ�-��ǥ ��ȯ ��ü�� ����
var geocoder = new daum.maps.services.Geocoder();

//��Ŀ�� �̸� ����
var marker = new daum.maps.Marker({
	 position: new daum.maps.LatLng(37.537187, 127.005476),
	 map: map
});

function sample5_execDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			// �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
			// �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
			var fullAddr = data.address; // ���� �ּ� ����
			var extraAddr = ''; // ������ �ּ� ����
			
			// �⺻ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
			if(data.addressType === 'R'){
				//���������� ���� ��� �߰��Ѵ�.
				if(data.bname !== ''){
					extraAddr += data.bname;
				}
				// �ǹ����� ���� ��� �߰��Ѵ�.
				if(data.buildingName !== ''){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				// �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
				fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
			}
			
			// �ּ� ������ �ش� �ʵ忡 �ִ´�.
			document.getElementById("sample5_address").value = fullAddr;
			// �ּҷ� �� ������ �˻�
			geocoder.addressSearch(data.address, function(results, status) {
				// ���������� �˻��� �Ϸ������
				if (status === daum.maps.services.Status.OK) {
					
					var result = results[0]; //ù��° ����� ���� Ȱ��

					// �ش� �ּҿ� ���� ��ǥ�� �޾Ƽ�
					var coords = new daum.maps.LatLng(result.y, result.x);
					
					// ������ �����ش�.
					mapContainer.style.display = "block";
					map.relayout();
					
					// ���� �߽��� �����Ѵ�.
					map.setCenter(coords);
					
					// ��Ŀ�� ��������� ���� ��ġ�� �ű��.
					marker.setPosition(coords)
					
				 }
			});
			
		}
	
	}).open();
	
}

</script>
</body>
</html>