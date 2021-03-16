<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="SpoolLocationMap.aspx.cs" Inherits="SpoolMove_SpoolLocationMap" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script type="text/javascript">

        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
    </script>
    <style>
        .submitbutton {
            border: 0;
            padding: 0 30px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            font-size: 12px;
            color: #fff;
            text-shadow: #007dab 0 1px 0;
            background: #0092c8;
            -moz-border-radius: 50px;
            -webkit-border-radius: 50px;
            border-radius: 50px;
            cursor: pointer;
        }

        .label {
            margin: 5px 10px 5px 0;
        }

        .inputText {
            vertical-align: middle;
            margin: 5px 10px 5px 0;
            padding: 6px;
            background-color: #fff;
            border: 1px solid #ddd;
            width: 300px;
        }

        .ui-autocomplete {
            max-height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
        }

        html .ui-autocomplete {
            height: 100px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var map;
            var projectID = 4;

            $("#autocomplete").autocomplete({
                source: function (request, response) {
                    $.getJSON("https://maakuthari.com/AmoghMobileService/IsomericService.asmx/GetSpools?ProjId=" + projectID + "&IsoTitle="
                        + request.term, function (data) {
                            response($.map(data, function (value, key) {
                                return {
                                    label: value.IsoTitle1 + "/" + value.PieceNo,
                                    value: value.IsoTitle1 + "/" + value.PieceNo
                                };
                            }));
                        });
                },
                autoFocus: true
            });

            function ParseDate(input) {
                var dt = new Date(parseInt(input.replace(/(^.*\()|([+-].*$)/g, '')));
                var dateTimeFormat = dt.getDate() + "/" + (dt.getMonth() + 1) + "/" + dt.getFullYear();
                return dateTimeFormat;
            }

            $("#submitBtn").click(function () {
                var selectedSpool = $("#autocomplete").val();
                if (selectedSpool == "") {
                    alert("Select Spool");
                    return false;
                }
                $("#spoolLocationDetails").css("display", "block");
                var inputValues = selectedSpool.split('/');
                var availableLocations = [];
                //var bounds = new google.maps.LatLngBounds();
                //var map;
                //var mapOptions = {
                //     mapTypeId: 'roadmap'
                //};

                // Display a map on the page
                //map = new google.maps.Map(document.getElementById("map"), mapOptions);

                var map = new google.maps.Map(document.getElementById('map'), {
                    center: new google.maps.LatLng(38.938074, 117.77032),
                    zoom: 2,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });

                var infoWindow = new google.maps.InfoWindow();

                var url1 = "https://maakuthari.com/AmoghMobileService/SpoolLocationService.asmx/GetSpoolLatLong?ProjId=" + projectID + "&IsoTitle=" + inputValues[0] + "&Sheet=01/01&PieceNo=" + inputValues[1] + "";
                fetch(url1)
                    .then(
                        function (response) {
                            response.json().then(function (data) {
                                $.each(data, function (key, val) {
                                    availableLocations.push(val);
                                });
                                var tripCoordinates = [];
                                var lat_Lng;
                                for (var i = 0; i < availableLocations.length; i++) {
                                    var datas = availableLocations[i];
                                    //var map = new google.maps.Map(document.getElementById('map'), {
                                    //      center: new google.maps.LatLng(datas.Latitude, datas.Longitude),
                                    //      zoom: 2,
                                    //      mapTypeId: google.maps.MapTypeId.ROADMAP
                                    //  });
                                    var latLng = new google.maps.LatLng(datas.Latitude, datas.Longitude);
                                    //var position = new google.maps.LatLng(datas.Latitude, datas.Longitude);
                                    //bounds.extend(position);
                                    tripCoordinates.push(new google.maps.LatLng(datas.Latitude, datas.Longitude));
                                    var marker = new google.maps.Marker({
                                        position: latLng,
                                        map: map,
                                        title: 'Spool Location'
                                    });

                                    (function (marker, datas) {
                                        google.maps.event.addListener(marker, "click", function (e) {
                                            infoWindow.setContent(datas.IsoTitle1 + " / " + datas.PieceNo + "<br/>" + datas.TransNo + "<br/>" + ParseDate(datas.createDate));
                                            infoWindow.open(map, marker);
                                        });
                                    })(marker, datas);

                                    // map.fitBounds(bounds);
                                };
                                var line = new google.maps.Polyline({
                                    path: tripCoordinates,
                                    geodesic: true,
                                    strokeColor: '#4986E7',
                                    strokeOpacity: 1.0,
                                    strokeWeight: 5
                                });

                                line.setMap(map);
                            });
                        }
                    )
                    .catch(function (err) {
                        console.log('Fetch Error :-S', err);
                    });

                var splURL = "https://maakuthari.com/AmoghReportsService/SpoolLocation.asmx/GetSpoolMovementDetails?ProjId=" + projectID + "&IsoTitile=" + inputValues[0] + "&Spool=" + inputValues[1] + "";
                fetch(splURL)
                    .then(
                        function (response) {
                            //var divId = document.getElementById("divLocationDetails");
                            response.json().then(function (data) {
                                $("#spnIsoName").text((data[0].ISO_TITLE1 == null) ? "" : data[0].ISO_TITLE1);
                                $("#spnTranserNo").text((data[0].SPL_TRANSFER_NO == null) ? "" : data[0].SPL_TRANSFER_NO);
                                $("#spnSplName").text((data[0].SPOOL == null) ? "" : data[0].SPOOL);
                                $("#spnTransferDate").text((data[0].SPL_TRANSFER_DATE == null) ? "" : data[0].SPL_TRANSFER_DATE);
                                $("#spnFitupDate").text((data[0].FITUP_DATE == null) ? "" : data[0].FITUP_DATE);
                                $("#spnTranferReason").text((data[0].SPL_TRANSFER_REASON == null) ? "" : data[0].SPL_TRANSFER_REASON);
                                $("#spnWeldDate").text((data[0].WELD_DATE == null) ? "" : data[0].WELD_DATE);
                                $("#spnRecieveNo").text((data[0].SPOOL_RECEIVE_NO == null) ? "" : data[0].SPOOL_RECEIVE_NO);
                                $("#spnIrnBeforePaintNo").text((data[0].SPL_IRN_BEFORE_PAINT_NO == null) ? "" : data[0].SPL_IRN_BEFORE_PAINT_NO);
                                $("#spnReciveDate").text((data[0].SPOOL_RECEIVE_DATE == null) ? "" : data[0].SPOOL_RECEIVE_DATE);
                                $("#spnIrnBeforePaintDate").text((data[0].SPL_IRN_BEFORE_PAINT_DATE == null) ? "" : data[0].SPL_IRN_BEFORE_PAINT_DATE);
                                $("#spnReqNo").text((data[0].SPL_REQUEST_NO == null) ? "" : data[0].SPL_REQUEST_NO);
                                $("#spnIrnAfterPaintNo").text((data[0].SPL_IRN_AFTER_PAINT_NO == null) ? "" : data[0].SPL_IRN_AFTER_PAINT_NO);
                                $("#spnReqDate").text((data[0].SPL_REQUEST_DATE == null) ? "" : data[0].SPL_REQUEST_DATE);
                                $("#spnIrnAfterPaintDate").text((data[0].SPL_IRN_AFTER_PAINT_DATE == null) ? "" : data[0].SPL_IRN_AFTER_PAINT_DATE);
                                $("#spnReturnNo").text((data[0].SPL_RETURN_NO == null) ? "" : data[0].SPL_RETURN_NO);
                                $("#spnSrnNo").text((data[0].SPL_SRN_NO == null) ? "" : data[0].SPL_SRN_NO);
                                $("#spnReturnDate").text((data[0].SPL_RETURN_DATE == null) ? "" : data[0].SPL_RETURN_DATE);
                                $("#spnSrnDate").text((data[0].SPL_SRN_DATE == null) ? "" : data[0].SPL_SRN_DATE);
                                $("#spnJobCardDate").text((data[0].JOBCARD_DATE == null) ? "" : data[0].JOBCARD_DATE);
                                $("#spnNDECompleteDate").text((data[0].NDE_CMPLT == null) ? "" : data[0].NDE_CMPLT);
                                $("#spnPaintClearDate").text((data[0].PAINT_CLR == null) ? "" : data[0].PAINT_CLR);

                            });
                        }
                    )
                    .catch(function (err) {
                        console.log('Fetch Error :-S', err);
                    });
            });
        });
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCZJqeuzeL4OLYfMGg7PqSAl6JcekFjmR8"></script>

    <div style="background-color: gainsboro;">
        <table>
            <tr>
                <td style="background-color: Gainsboro; width: 100%; text-align: right">Select Spool</td>
                <td>
                    <input id="autocomplete" class="inputText" onkeypress="handleSpace(event)">
                </td>
                <td>
                    <button type="button" class="submitbutton" id="submitBtn">Submit</button>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: whitesmoke; padding: 3px; margin: 3px; border-radius: 5px; width: 100%">
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div id="spoolLocationDetails" style="display: none; width: 100%">
                    <div id="map" style="width: 100%; height: 500px;"></div>
                    <br />
                    <span style="color: #0722EF; font-family: inherit; font-size: medium;">Spool Details:</span><br />
                    <%--<div id="divLocationDetails" style="background-color: lightblue;"></div>--%>
                    <table style="width: 100%; background-color: lightblue" border="1">

                        <tr>
                            <td colspan="2" style="text-align: center; font-weight: bold; color: black; background-color: antiquewhite; padding-left: 2px;">ISO SPOOL DETAILS</td>
                            <td colspan="3" style="text-align: center; font-weight: bold; color: black; padding-left: 2px; background-color: antiquewhite;">SPOOL MOVEMENT DETAILS</td>
                            <td style="text-align: center; font-weight: bold; color: black; padding-left: 2px; background-color: antiquewhite;">REMARKS</td>
                        </tr>

                        <tr>
                            <td style="padding: 4px; width: 120px;"><span style="color: black; font-weight: bold; padding-left: 2px;">ISO NAME</span></td>
                            <td style="padding: 4px; width: 180px;"><span style="color: black; padding-left: 2px;" id="spnIsoName"></span></td>
                            <td style=""><span style="color: black; padding-left: 2px; font-weight: bold;">SPL IRN BEFORE PAINT NO</span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px;" id="spnIrnBeforePaintNo"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id="spnIrnBeforePaintDate"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id=""></span></td>
                        </tr>

                        <tr>
                            <td style="padding: 4px; width: 120px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL NAME</span></td>
                            <td style="padding: 4px; width: 180px;"><span style="color: black; padding-left: 2px;" id="spnSplName"></span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL IRN AFTER PAINT NO</span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px;" id="spnIrnAfterPaintNo"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black;" id="spnIrnAfterPaintDate"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id=""></span></td>

                        </tr>

                        <tr>

                            <td style="padding: 4px; width: 120px;"><span style="color: black; padding-left: 2px; font-weight: bold;">JOBCARD DATE</span></td>
                            <td style="padding: 4px; width: 180px;"><span style="color: black; padding-left: 2px;" id="spnJobCardDate"></span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL SRN NO</span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px;" id="spnSrnNo"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id="spnSrnDate"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id=""></span></td>

                        </tr>

                        <tr>
                            <td style="padding: 4px; width: 120px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL FITUP DATE</span></td>
                            <td style="padding: 4px; width: 180px;"><span style="color: black; padding-left: 2px;" id="spnFitupDate"></span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL TRANSFER NO</span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px;" id="spnTranserNo"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id="spnTransferDate"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id="spnTranferReason"></span></td>
                        </tr>

                        <tr>
                            <td style="padding: 4px; width: 120px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL WELD DATE</span></td>
                            <td style="padding: 4px; width: 180px;"><span style="color: black; padding-left: 2px;" id="spnWeldDate"></span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL RECEIVE NO</span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px;" id="spnRecieveNo"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id="spnReciveDate"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id=""></span></td>

                        </tr>

                        <tr>
                            <td style="padding: 4px; width: 120px;"><span style="color: black; padding-left: 2px; font-weight: bold;">NDE COMPLETE DATE</span></td>
                            <td style="padding: 4px; width: 180px;"><span style="color: black; padding-left: 2px;" id="spnNDECompleteDate"></span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL REQUEST NO</span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px;" id="spnReqNo"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id="spnReqDate"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id=""></span></td>

                        </tr>

                        <tr>
                            <td style="padding: 4px; width: 120px;"><span style="color: black; padding-left: 2px; font-weight: bold;">PAINT CLEAR DATE</span></td>
                            <td style="padding: 4px; width: 180px;"><span style="color: black; padding-left: 2px;" id="spnPaintClearDate"></span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px; font-weight: bold;">SPL RETURN NO</span></td>
                            <td style="padding: 4px; width: 150px;"><span style="color: black; padding-left: 2px;" id="spnReturnNo"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id="spnReturnDate"></span></td>
                            <td style="padding: 4px; width: 70px;"><span style="color: black; padding-left: 2px;" id=""></span></td>

                        </tr>

                    </table>


                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
