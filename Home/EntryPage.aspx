<%@ Page Title="Entry Page" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="EntryPage.aspx.cs"
    Inherits="EntryPage_data" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadPanelBar1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;

            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();



        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= BomRadGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        (function () {

            var panelBar;
            var PanelBarpageTab;
            var multiPage;

            window.onLoad = function (sender) {
                panelBar = sender;
                PanelBarpageTab = panelBar.get_items().getItem(0);
                multiPage = panelBar.get_items().getItem(0).findControl("RadMultiPage1");
            };

            window.onItemClicked = function (sender, eventArgs) {
                if (!PanelBarpageTab.get_selected()) {
                    PanelBarpageTab.expand();
                    PanelBarpageTab.select();
                }

                var pageView = multiPage.get_pageViews().getPageView(
                    eventArgs.get_item().get_index());

                pageView.set_selected(true);
            };


            window.stopPropagation = function (e) {
                e.cancelBubble = true;

                if (e.stopPropagation)
                    e.stopPropagation();
            };
        }())
        var confirmWindow = null;
        var btnSpoolDtDelete = null;
        var btnYes = null;
        function OnSplDelete(sender, args) {
            confirmWindow.show();
            btnYes.focus();
            args.set_cancel(true);
        }


        function YesOrNoClicked(sender, args) {
            confirmWindow.close();
            if (sender.get_text() == "Yes") {
                btnSpoolDtDelete.click();
            }
        }
        function pageLoad() {
            confirmWindow = $find("<%=confirmWindow.ClientID %>");
            btnSpoolDtDelete = $find("<%=btnSpoolDtDelete.ClientID %>");
            btnYes = $find("<%=btnYes.ClientID%>");
        }
        function onNdtJointDelete(sender, args) {
            args.set_cancel(!window.confirm("Are you sure you want to Delete?"));
        }
    </script>
    <style type="text/css">
        #example .PanelData {
            padding: 75px 0 0 0 !important;
            width: 100%;
            background: #588a4d 1px 1px no-repeat;
        }

        .PanelData .PanelItemData {
        }

            .PanelData .PanelItemData .RadMenu {
                float: left;
                z-index: 2900;
            }

            .PanelData .PanelItemData .extra_button {
                float: right;
                position: relative;
                top: 4px;
                right: 2px;
            }


        .linksPanel {
            position: absolute;
            right: 30px;
            bottom: 30px;
            width: 200px;
            height: 30px;
            text-align: right;
        }

        .RadPanelBar .rpFirst .rpTemplate {
            zoom: 1;
            height: 94px;
            width: 100%;
        }

        .linksPanel a {
            color: White;
        }


        .rpTemplate .pageUiList {
            padding: 0;
            width: 950px;
            margin: 0 auto;
            display: block;
        }

            .rpTemplate .pageUiList:after {
                content: ".";
                display: block;
                visibility: hidden;
                font-size: 0;
                line-height: 0;
                overflow: hidden;
                height: 0;
                clear: both;
            }

            .rpTemplate .pageUiList li {
                list-style-type: none;
                float: left;
                text-align: left;
                margin: 2px 0 0;
                padding: 5px;
                border-right: 1px solid red;
            }

                .rpTemplate .pageUiList li.lastLi {
                    border-right-width: 0;
                }



        div.RadPanelBar .rpTemplate {
            background: #EDF9FE;
            overflow: hidden !important;
        }

        .rpHeaderTemplate {
            overflow: hidden;
            height: 26px;
        }
    </style>

    <telerik:RadWindow RenderMode="Lightweight" ID="confirmWindow" runat="server" VisibleTitlebar="false" VisibleStatusbar="false"
        Modal="true" Behaviors="None" Height="170px" Width="330px" Style="z-index: 100001">
        <ContentTemplate>
            <div style="margin-top: 30px; float: left;">
                <div style="width: 60px; padding-left: 15px; float: left;">
                    <img src="../images/Alert.png" alt="Confirm Page" />
                </div>
                <div style="width: 200px; float: left;">
                    <asp:Label ID="lblConfirm" Font-Size="14px" Text="Are you sure you want to Delete?"
                        runat="server"></asp:Label>
                    <br />
                    <br />
                    <telerik:RadButton RenderMode="Lightweight" ID="btnYes" runat="server" Text="Yes" AutoPostBack="false" OnClientClicked="YesOrNoClicked">
                        <Icon PrimaryIconCssClass="rbOk"></Icon>
                    </telerik:RadButton>
                    <telerik:RadButton RenderMode="Lightweight" ID="btnNo" runat="server" Text="No" AutoPostBack="false" OnClientClicked="YesOrNoClicked">
                        <Icon PrimaryIconCssClass="rbCancel"></Icon>
                    </telerik:RadButton>
                </div>
            </div>
        </ContentTemplate>
    </telerik:RadWindow>
    <table>
        <tr>
            <td>
                <telerik:RadComboBox ID="ddlIsometric" runat="server" DataSourceID="IsoDataSource" DataTextField="ISO_TITLE1" AllowCustomText="true"
                    Filter="Contains" DataValueField="ISO_ID" Width="250px" OnSelectedIndexChanged="ddlIsometric_SelectedIndexChanged"
                    AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select Isometric Num"
                    ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                </telerik:RadComboBox>
            </td>

            <td>
                <asp:ImageButton ID="ImageIsoButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" ToolTip="New Iso" CausesValidation="false" />
            </td>
            <td>
                <asp:ImageButton ID="ImageIsoButtonDetails" runat="server" ImageUrl="~/Images/icons/show-menu-icon.png"
                    OnClick="ImageIsoButtonDetails_Click" ToolTip="Iso Data" CausesValidation="false" />
            </td>
            <td>
                <telerik:RadButton ID="btnRevisions" runat="server" Text="Revisions" Width="80px" OnClick="btnRevisions_Click" CausesValidation="false"></telerik:RadButton>
            </td>
            <td>
                <telerik:RadButton ID="btnNewRevision" runat="server" Text="New Rev" OnClick="btnNewRevision_Click" Width="100px" CausesValidation="false"></telerik:RadButton>
            </td>
            <td>
                <telerik:RadButton ID="btnIsoPDF" runat="server" Text="PDF" OnClick="btnIsoPDF_Click" Width="150px" CausesValidation="false"></telerik:RadButton>

            </td>
            <td>
                <telerik:RadButton ID="btnIsoMto" runat="server" Text="ISO MTO" OnClick="btnIsoMto_Click" Width="100px" CausesValidation="false"></telerik:RadButton>

            </td>

            <td>
                <table>
                    <tr>
                        <td>
                            <telerik:RadMenu ID="RadBulkImport" runat="server" EnableOverlay="false" CssClass="RadMenuStyle"
                                OnItemClick="RadBulkImport_ItemClick" Visible="false" Style="z-index: 500">
                                <Items>
                                    <telerik:RadMenuItem Text="Bulk Import" Value="0" ImageUrl="../Images/icons/arrow-down.png">
                                        <Items>
                                            <telerik:RadMenuItem Text="Bulk Iso Data Upload" Value="35"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk Spool Import" Value="44"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk Joints Import" Value="45"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk Bom Import" Value="46"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk JC Without Condtions" Value="31"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk Fitup&Weld Without Condtions" Value="30"></telerik:RadMenuItem>
                                            <telerik:RadMenuItem Text="Bulk NDT Without Condtions" Value="32"></telerik:RadMenuItem>

                                        </Items>
                                    </telerik:RadMenuItem>
                                </Items>
                            </telerik:RadMenu>
                        </td>
                    </tr>
                </table>

            </td>


        </tr>
        <tr>
            <td>
                <telerik:RadComboBox ID="ddlSpool" runat="server" DataSourceID="SplDataSource" DataTextField="SPOOL" AllowCustomText="true"
                    Filter="Contains" DataValueField="SPL_ID" Width="250px" OnSelectedIndexChanged="ddlSpool_SelectedIndexChanged"
                    AutoPostBack="true" CausesValidation="false" EmptyMessage="Select Spool">
                </telerik:RadComboBox>
            </td>
            <td>
                <asp:ImageButton ID="ImageSplButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" ToolTip="New Spool"
                    OnClick="ImageSplButtonAdd_Click" CausesValidation="false" />
            </td>
            <td>

                <asp:ImageButton ID="ImageSplButtonDetails" runat="server" ImageUrl="~/Images/icons/show-menu-icon.png"
                    OnClick="ImageSplButtonDetails_Click" ToolTip="Spool Data" CausesValidation="false" />
            </td>
            <td>
                <telerik:RadButton ID="btnSplPDF" runat="server" Text="PDF" OnClick="btnSplPDF_Click" Width="80px" CausesValidation="false"></telerik:RadButton>

            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                    <ContentTemplate>
                        <telerik:RadButton ID="btnSplDelete" runat="server" Text="Spl Delete" Width="100px" OnClick="btnSplDelete_Click"></telerik:RadButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                <ContentTemplate>
                                    <telerik:RadButton ID="btnSplYes" runat="server" Text="Yes" Width="50px" OnClick="btnSplYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel11" runat="server">
                                <ContentTemplate>
                                    <telerik:RadButton ID="btnSplNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>

            </td>

        </tr>
        <tr>
            <td>
                <telerik:RadComboBox ID="ddlJoint" runat="server" DataSourceID="JointDataSource" DataTextField="JOINT_NO" AllowCustomText="true"
                    Filter="Contains" DataValueField="JOINT_ID" Width="250px"
                    AutoPostBack="true" CausesValidation="false" EmptyMessage="Select Joint" OnSelectedIndexChanged="ddlJoint_SelectedIndexChanged">
                </telerik:RadComboBox>
            </td>
            <td>
                <asp:ImageButton ID="ImageJntButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" ToolTip="New Joint"
                    OnClick="ImageJntButtonAdd_Click" CausesValidation="false" />
            </td>
            <td>

                <asp:ImageButton ID="ImageJntButtonDetails" runat="server" ImageUrl="~/Images/icons/show-menu-icon.png"
                    OnClick="ImageJntButtonDetails_Click" ToolTip="Joint Data" CausesValidation="false" />
            </td>
            <td>

                <telerik:RadButton ID="btnWeldingDt" runat="server" Text="Welding" OnClick="btnWeldingDt_Click" Width="80px" CausesValidation="false"></telerik:RadButton>

            </td>
            <td>

                <telerik:RadButton ID="btnNdtDt" runat="server" Text="NDE" OnClick="btnNdtDt_Click" Width="100px" CausesValidation="false"></telerik:RadButton>

            </td>

            <td>
                <telerik:RadButton ID="btnSetItemCode" runat="server" Text="BOM Connection" OnClick="btnSetItemCode_Click" Width="150px" CausesValidation="false"></telerik:RadButton>
            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <telerik:RadButton ID="BtnJntMove" runat="server" Text="Move To" Width="100px" OnClick="BtnJntMove_Click"></telerik:RadButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                <ContentTemplate>
                                    <telerik:RadDropDownList ID="cboJointMove" runat="server" DataSourceID="SpoolDataSource"
                                        DataTextField="SHEET_SPOOL" DataValueField="SPL_ID" Visible="False"
                                        Width="132px" AppendDataBoundItems="True">
                                        <Items>
                                            <telerik:DropDownListItem Value="-1" Text="(Select)" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>

                        <td>
                            <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                <ContentTemplate>
                                    <telerik:RadButton ID="btnJntDone" runat="server" Text="Done" Width="120" OnClick="btnJntDone_Click" Visible="false"></telerik:RadButton>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>

                    </tr>
                </table>

            </td>


        </tr>

    </table>
    <table>
        <tr>
            <td>
                <telerik:RadComboBox ID="ddlBom" runat="server" DataSourceID="BomDataSource" DataTextField="PT_NO" AllowCustomText="true"
                    Filter="Contains" DataValueField="BOM_ID" Width="250px"
                    AutoPostBack="true" CausesValidation="false" EmptyMessage="Select Bom" EnableVirtualScrolling="true">
                </telerik:RadComboBox>
            </td>
            <td>
                <asp:ImageButton ID="ImageBomButtonAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" ToolTip="New Bom"
                    OnClick="ImageBomButtonAdd_Click" CausesValidation="false" />
            </td>
            <td>

                <asp:ImageButton ID="ImageBomButtonDetails" runat="server" ImageUrl="~/Images/icons/show-menu-icon.png"
                    OnClick="ImageBomButtonDetails_Click" ToolTip="Bom Data" CausesValidation="false" />
            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <telerik:RadButton ID="btnItemCode" runat="server" Text="Edit Item Code" Width="120px"
                            OnClick="btnItemCode_Click" CausesValidation="False">
                        </telerik:RadButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <telerik:RadButton ID="btnMove" runat="server" Text="Move To" Width="80" OnClick="btnMove_Click"></telerik:RadButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>

            <td>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                    <ContentTemplate>
                        <telerik:RadDropDownList ID="cboBomMove" runat="server" AppendDataBoundItems="True" DataSourceID="SpoolDataSource"
                            DataTextField="SHEET_SPOOL" DataValueField="SPL_ID" Visible="False"
                            Width="150px">
                            <Items>
                                <telerik:DropDownListItem Value="-1" Text="New Spool" />
                            </Items>
                        </telerik:RadDropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                    <ContentTemplate>
                        <telerik:RadButton ID="btnDone" runat="server" Text="Done" Width="60px" Visible="False" OnClick="btnDone_Click"></telerik:RadButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <table id="ItemCodeUpdate" runat="server" visible="false">
                            <tr>
                                <td>Item Code
                                </td>
                                <td style="width: 220px">
                                    <telerik:RadTextBox ID="txtItemCode" runat="server" Width="200px"></telerik:RadTextBox>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnSaveItemCode" runat="server" Text="Save" Width="80" OnClick="btnSaveItemCode_Click"></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <div class="PanelData size-wide no-bg">
        <telerik:RadPanelBar RenderMode="Lightweight" runat="server" ID="RadPanelBar1" Width="100%" Height="350px"
            ExpandMode="FullExpandedItem" OnClientLoad="onLoad" AllowCollapseAllItems="true">
            <Items>
                <telerik:RadPanelItem Expanded="true" CssClass="PanelItemData">
                    <HeaderTemplate>
                        <telerik:RadMenu RenderMode="Lightweight" runat="server" ID="RadMenu1" OnClientItemClicked="onItemClicked"
                            Skin="Telerik">
                            <Items>
                                <telerik:RadMenuItem Text="Spool" Selected="true" />
                                <telerik:RadMenuItem Text="Joints" />

                            </Items>
                        </telerik:RadMenu>

                    </HeaderTemplate>
                    <ContentTemplate>
                        <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" CssClass="multiPage" ScrollBars="Auto">

                            <telerik:RadPageView runat="server" ID="RadPageView1" Width="100%" Height="300">
                                <ul class="pageUiList">
                                    <li class="lastLi">
                                        <div style="padding-left: 30px">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="RadComTransCat" runat="server" DataSourceID="TransCatDataSource" DataTextField="CATEGORY" AllowCustomText="true"
                                                            Filter="Contains" DataValueField="CAT_ID" Width="200px" DropDownWidth="250px" Height="200px" AutoPostBack="true" CausesValidation="false"
                                                            EmptyMessage="Select Spool Activity" OnSelectedIndexChanged="RadComTransCat_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                        <asp:SqlDataSource ID="SplReqDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
                                                            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
                                                            SelectCommand='SELECT TRANS_ID AS UNIQ_ID, SER_NO AS UNIQ_TEXT FROM  PIP_SPOOL_TRANS WHERE CAT_ID=:CAT_ID 
                                                            UNION 
                                                           SELECT TRANS_ID AS UNIQ_ID, TRANS_NO AS UNIQ_TEXT  FROM PIP_SPL_TRANSFER WHERE 14=:CAT_ID
                                                            UNION 
                                                           SELECT RCV_ID AS UNIQ_ID, RCV_NO AS UNIQ_TEXT  FROM PIP_SPL_RECEIVE WHERE 13=:CAT_ID
                                                            UNION 
                                                           SELECT WO_ID AS UNIQ_ID, WO_NAME AS UNIQ_TEXT  FROM PIP_WORK_ORD WHERE 100=:CAT_ID
                                                            UNION 
                                                           SELECT SPL_PNT_ID AS UNIQ_ID, PNT_REQ_NO AS UNIQ_TEXT  FROM PIP_PAINTING_SPL WHERE 101=:CAT_ID
                                                         ORDER BY UNIQ_TEXT'>
                                                            <SelectParameters>
                                                                <asp:ControlParameter DefaultValue="-1" Name="CAT_ID" PropertyName="SelectedValue" ControlID="RadComTransCat" Type="Decimal" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>

                                                    </td>
                                                    <td>
                                                        <telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk Import" Width="140" OnClick="btnBulkImport_Click"></telerik:RadButton>
                                                    </td>
                                                </tr>
                                            </table>



                                        </div>
                                    </li>
                                </ul>

                                <ul class="pageUiList">

                                    <li>
                                        <div>
                                            <table style="padding: 5px">
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="RadComSpoolReq" runat="server" DataSourceID="SplReqDataSource" DataTextField="UNIQ_TEXT" AllowCustomText="true"
                                                            Filter="Contains" DataValueField="UNIQ_ID" Width="200px" DropDownWidth="250px" Height="200px" AutoPostBack="true" CausesValidation="false"
                                                            EnableAutomaticLoadOnDemand="true" EmptyMessage="Select  Request" OnSelectedIndexChanged="RadComSpoolReq_SelectedIndexChanged"
                                                            ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                    <td>
                                                        <asp:ImageButton ID="ImageSpoolDtNewAdd" runat="server" ImageUrl="~/Images/icons/add-blue.png" ToolTip="New Request" OnClick="ImageSpoolDtNewAdd_Click" />
                                                    </td>
                                                </tr>
                                                <div runat="server" id="DivPaint" visible="false">
                                                    <tr>

                                                        <td>
                                                            <telerik:RadTextBox ID="txt1stPaint" runat="server" Width="200px" EmptyMessage="1st Paint Report Num" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="date1stPaint" runat="server" DateInput-DateFormat="dd-MMM-yyyy" onkeypress="handleSpace(event)"
                                                                DateInput-EmptyMessage="1st Paint Date">
                                                                <Calendar runat="server">
                                                                    <SpecialDays>
                                                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                        </telerik:RadCalendarDay>
                                                                    </SpecialDays>
                                                                </Calendar>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadTextBox ID="txt2ndPaint" runat="server" Width="200px" EmptyMessage="2nd Paint Report Num" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="date2ndPaint" runat="server" DateInput-DateFormat="dd-MMM-yyyy" onkeypress="handleSpace(event)"
                                                                DateInput-EmptyMessage="2nd Paint Date">
                                                                <Calendar runat="server">
                                                                    <SpecialDays>
                                                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                        </telerik:RadCalendarDay>
                                                                    </SpecialDays>
                                                                </Calendar>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadTextBox ID="txt3rdPaint" runat="server" Width="200px" EmptyMessage="3rd Paint Report Num" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="date3rdPaint" runat="server" DateInput-DateFormat="dd-MMM-yyyy" onkeypress="handleSpace(event)"
                                                                DateInput-EmptyMessage="3rd Paint Date">
                                                                <Calendar runat="server">
                                                                    <SpecialDays>
                                                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                        </telerik:RadCalendarDay>
                                                                    </SpecialDays>
                                                                </Calendar>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadTextBox ID="txtBlast" runat="server" Width="200px" EmptyMessage="Blast Report Num" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                                                        </td>
                                                        <td>
                                                            <telerik:RadDatePicker ID="dateBlast" runat="server" DateInput-DateFormat="dd-MMM-yyyy" onkeypress="handleSpace(event)">
                                                                <Calendar runat="server">
                                                                    <SpecialDays>
                                                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                        </telerik:RadCalendarDay>
                                                                    </SpecialDays>
                                                                </Calendar>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                </div>
                                                <tr>
                                                    <td>
                                                        <telerik:RadDropDownList ID="ddlSubStore" runat="server" DataSourceID="dsSubStore" SelectedText="Select SubStore"
                                                            SelectedValue="" DataTextField="STORE_L1" DataValueField="SUBSTORE_ID" Width="200px" DropDownWidth="250px" DropDownHeight="200px"
                                                            AppendDataBoundItems="true" Visible="false">
                                                            <Items>
                                                                <telerik:DropDownListItem Selected="true" Value="" Text="Select SubStore" />
                                                            </Items>
                                                        </telerik:RadDropDownList>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px" EmptyMessage="Remarks" TextMode="MultiLine" Resize="Both" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <telerik:RadButton ID="btnDataImport" runat="server" Text="Import Spool" Width="140" Visible="false" OnClick="btnDataImport_Click"></telerik:RadButton>
                                                    </td>

                                                </tr>


                                                <tr>
                                                    <td>
                                                        <telerik:RadButton ID="btnSpoolDtSave" runat="server" Text="Save" Width="60" OnClick="btnSpoolDtSave_Click" Visible="false"></telerik:RadButton>
                                                        <telerik:RadButton ID="btnSpoolDtUpdate" runat="server" Text="Update" Width="60" OnClick="btnSpoolDtUpdate_Click" Visible="false"></telerik:RadButton>
                                                        <telerik:RadButton ID="btnSpoolDtDelete" runat="server" Text="Delete" Width="60" OnClick="btnSpoolDtDelete_Click"
                                                            Visible="false" OnClientClicking="OnSplDelete">
                                                        </telerik:RadButton>
                                                    </td>

                                                </tr>

                                            </table>
                                        </div>

                                    </li>

                                    <li class="lastLi">

                                        <div>

                                            <%--<telerik:RadTextBox ID="txtExist" runat="server" Width="300px" TextMode="MultiLine" Enabled="false" Font-Bold="true" Height="150px"
                                                Visible="false"  Resize="Both">
                                            </telerik:RadTextBox>--%>
                                            <asp:UpdatePanel ID="UpdatePanel12" runat="server">
                                                <ContentTemplate>
                                                    <asp:Label ID="txtExist" runat="server" Text="<b>Spool Status</b>" Height="100%"></asp:Label>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </li>
                                </ul>
                            </telerik:RadPageView>
                            <telerik:RadPageView runat="server" ID="RadPageView2" Width="100%" Height="300">
                                <ul class="pageUiList">
                                    <li class="lastLi">
                                        <div style="padding-left: 30px">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadComboBox ID="RadComJointActivity" runat="server" DataSourceID="JointActivityDataSource" DataTextField="CATEGORY" AllowCustomText="true"
                                                            Filter="Contains" DataValueField="CAT_ID" Width="200px" DropDownWidth="250px" Height="200px" AutoPostBack="true" CausesValidation="false"
                                                            EmptyMessage="Select Joint Activity" OnSelectedIndexChanged="RadComJointActivity_SelectedIndexChanged">
                                                        </telerik:RadComboBox>


                                                    </td>
                                                    <td>
                                                        <telerik:RadDropDownList runat="server" ID="ddlSubcon" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                                            AutoPostBack="true" CausesValidation="false" Width="150px" DropDownWidth="250px" DropDownHeight="200px">
                                                        </telerik:RadDropDownList>
                                                    </td>
                                                    <td>
                                                        <telerik:RadButton ID="JointBulkImport" runat="server" Text="Bulk Import" CausesValidation="false" Width="140" OnClick="JointBulkImport_Click"></telerik:RadButton>
                                                    </td>
                                                </tr>
                                            </table>



                                        </div>
                                    </li>
                                </ul>
                                <ul class="pageUiList">

                                    <li>

                                        <table runat="server" id="Fitup_Entry" visible="false">
                                            <tr>
                                                <td>
                                                    <telerik:RadTextBox ID="txtFitupRep" runat="server" Width="200px" EmptyMessage="Fitup Report"></telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFitupRep"
                                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>

                                                <td>
                                                    <telerik:RadDatePicker ID="txtFitupDate" runat="server" Width="200px" DateInput-EmptyMessage="Fitup Date ">
                                                        <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                                        <Calendar runat="server">
                                                            <SpecialDays>
                                                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                </telerik:RadCalendarDay>
                                                            </SpecialDays>
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFitupDate"
                                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <telerik:RadComboBox ID="rcbHeatNo1" runat="server" DataSourceID="HeatNo1DataSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
                                                        Filter="Contains" AllowCustomText="true" EmptyMessage="Select Heat No1" AutoPostBack="true" Width="200px">
                                                    </telerik:RadComboBox>
                                                    <telerik:RadTextBox ID="txtSuppHeatNo1" runat="server" Width="200px" Visible="false"></telerik:RadTextBox>

                                                </td>

                                                <td>
                                                    <telerik:RadComboBox ID="rcbHeatNo2" runat="server" DataSourceID="HeatNo2DataSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
                                                        Filter="Contains" AllowCustomText="true" EmptyMessage="Select Heat No2" Width="200px">
                                                    </telerik:RadComboBox>
                                                    <telerik:RadTextBox ID="txtSuppHeatNo2" runat="server" Visible="false" Width="200px"></telerik:RadTextBox>

                                                </td>
                                            </tr>

                                            <tr>

                                                <td>
                                                    <telerik:RadDropDownList ID="ddlFitupInspCode" runat="server" DataSourceID="FitupInspDataSource" DataTextField="INSP_CODE" DataValueField="INSP_CODE" AppendDataBoundItems="true" Width="200px">
                                                        <Items>
                                                            <telerik:DropDownListItem Value="" Text="Select Inspector" Selected="true" />
                                                        </Items>
                                                    </telerik:RadDropDownList>
                                                    <asp:SqlDataSource ID="FitupInspDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
                                                        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
                                                        SelectCommand="SELECT INSP_CODE FROM PIP_INSPECTOR WHERE SUB_CON_ID=:SC_ID AND TYPE_ID=1">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                                                        </SelectParameters>
                                                    </asp:SqlDataSource>
                                                </td>

                                                <td>
                                                    <telerik:RadTextBox ID="txtFitupForeman" runat="server" EmptyMessage="Foreman" Width="200px"></telerik:RadTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadButton ID="FitupSave" runat="server" OnClick="FitupSave_Click" Text="Save"></telerik:RadButton>
                                                </td>
                                            </tr>
                                        </table>

                                        <table runat="server" id="Weld_Entry" visible="false">
                                            <tr>
                                                <td>
                                                    <table>

                                                        <tr>

                                                            <td>
                                                                <telerik:RadComboBox ID="ddlWeldWps" runat="server" DataSourceID="wpsDataSource" DataTextField="WPS_NO1" DataValueField="WPS_ID"
                                                                    Filter="Contains" AllowCustomText="true" AutoPostBack="true" EmptyMessage="WPS No" Width="200px" CausesValidation="false">
                                                                </telerik:RadComboBox>

                                                                <asp:SqlDataSource ID="wpsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
                                                                    ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WPS_ID, WPS_NO1
                                                                                                        FROM PIP_WPS_NO
                                                                                                        WHERE (PROJECT_ID = :PROJECT_ID)                                                                                                        
                                                                                                                AND :JOINT_SIZE_DEC  BETWEEN SIZE_FROM AND SIZE_TO 
                                                                                                                AND :JOINT_THK BETWEEN THK_FROM AND THK_TO 
                                                                                                        ORDER BY WPS_NO1">

                                                                    <SelectParameters>
                                                                        <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                                                                        <asp:ControlParameter ControlID="txtJoint_size" DefaultValue="-1" Name="JOINT_SIZE_DEC" PropertyName="Text" />
                                                                        <asp:ControlParameter ControlID="txtJoint_thk" DefaultValue="-1" Name="JOINT_THK" PropertyName="Text" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </td>
                                                        </tr>

                                                        <tr>

                                                            <td>
                                                                <telerik:RadTextBox ID="txtWeldRepNo" runat="server" EmptyMessage="Weld Report No" Width="200px"></telerik:RadTextBox>
                                                                <asp:RequiredFieldValidator runat="server" ID="rfv1" ControlToValidate="txtWeldRepNo" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <telerik:RadDatePicker ID="txtWeldDate" runat="server" DateInput-EmptyMessage="Weld Date" Width="200px">
                                                                    <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                                                    <Calendar runat="server">
                                                                        <SpecialDays>
                                                                            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                            </telerik:RadCalendarDay>
                                                                        </SpecialDays>
                                                                    </Calendar>
                                                                </telerik:RadDatePicker>
                                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtWeldDate" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                        <tr>

                                                            <td>
                                                                <telerik:RadComboBox ID="rcbWeldInsp" runat="server" DataSourceID="WeldInspDataSource" DataTextField="INSP_CODE" DataValueField="INSP_CODE" Filter="Contains"
                                                                    AllowCustomText="true" EmptyMessage="Inspector Code" Width="200px" CausesValidation="false">
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="rcbWeldInsp" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                                <telerik:RadTextBox ID="txtJoint_size" runat="server" Visible="False"></telerik:RadTextBox>
                                                                <telerik:RadTextBox ID="txtJoint_thk" runat="server" Visible="False"></telerik:RadTextBox>
                                                                <asp:SqlDataSource ID="WeldInspDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
                                                                    ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
                                                                    SelectCommand="SELECT INSP_CODE FROM PIP_INSPECTOR WHERE SUB_CON_ID=:SC_ID AND TYPE_ID=2">
                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                        <tr>

                                                            <td>
                                                                <telerik:RadDatePicker ID="txtInspDate" runat="server" DateInput-EmptyMessage="Inspection Date" Width="200px">
                                                                    <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                                                    <Calendar runat="server">
                                                                        <SpecialDays>
                                                                            <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                            </telerik:RadCalendarDay>
                                                                        </SpecialDays>
                                                                    </Calendar>
                                                                </telerik:RadDatePicker>
                                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="txtInspDate" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>

                                                        <tr>

                                                            <td>
                                                                <telerik:RadTextBox ID="txtInspResult" runat="server" EmptyMessage="Inspection Result" Width="200px"></telerik:RadTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>

                                                            <td>
                                                                <telerik:RadTextBox ID="txtWeldForeman" runat="server" EmptyMessage="Foreman" Width="200px"></telerik:RadTextBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <telerik:RadButton ID="WeldSave" runat="server" OnClick="WeldSave_Click" Text="Save"></telerik:RadButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>

                                                <td rowspan="8" style="text-align: right; vertical-align: top">
                                                    <table style="text-align: left; vertical-align: top">
                                                        <tr>

                                                            <td>
                                                                <telerik:RadComboBox Skin="Windows7" ID="ddlWelder" runat="server" Width="150px" DataSourceID="welderDataSource" DataTextField="WELDER_NO"
                                                                    DataValueField="WELDER_ID" Filter="Contains" AllowCustomText="true" AutoPostBack="true" CausesValidation="false" EmptyMessage="Welder">
                                                                </telerik:RadComboBox>
                                                                <asp:SqlDataSource ID="welderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
                                                                    ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
                                                                    SelectCommand="SELECT WELDER_ID,WELDER_NO FROM VIEW_TOTAL_WLDR_QLF 
                                                                         WHERE :JOINT_SIZE BETWEEN SIZE_FROM AND SIZE_TO AND :JOINT_THK BETWEEN THK_FROM AND THK_TO 
                                                                         AND (PROJECT_ID = :PROJECT_ID)  AND (WPS_ID = :WPS_ID) ORDER BY WELDER_NO">

                                                                    <SelectParameters>
                                                                        <asp:ControlParameter ControlID="txtJoint_size" DefaultValue="-1" Name="JOINT_SIZE" PropertyName="Text" />
                                                                        <asp:ControlParameter ControlID="txtJoint_thk" DefaultValue="-1" Name="JOINT_THK" PropertyName="Text" />
                                                                        <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                                                                        <asp:ControlParameter ControlID="ddlWeldWps" DefaultValue="-1" Name="WPS_ID" PropertyName="SelectedValue" />
                                                                    </SelectParameters>
                                                                </asp:SqlDataSource>
                                                            </td>
                                                        </tr>
                                                        <tr>

                                                            <td>
                                                                <telerik:RadDropDownList ID="ddlWelderPass" runat="server" Width="150px" DataSourceID="WeldPassDataSource" DataTextField="WELD_PASS"
                                                                    DataValueField="PASS_ID" AppendDataBoundItems="true">
                                                                    <Items>
                                                                        <telerik:DropDownListItem Text="Select Pass" Value="-1" />
                                                                    </Items>
                                                                </telerik:RadDropDownList>

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <telerik:RadButton ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" CausesValidation="false" />
                                                                <telerik:RadButton ID="btnAddWelderAll" runat="server" Text="Add All" CausesValidation="false" OnClick="btnAddWelderAll_Click" />
                                                                <telerik:RadButton ID="btnRemove" runat="server" Text="Remove" OnClick="btnRemove_Click" CausesValidation="false" />
                                                                <telerik:RadButton ID="btnRemoveAll" runat="server" Text="Remove All" OnClick="btnRemoveAll_Click" CausesValidation="false" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <telerik:RadListBox ID="weldersListBox" runat="server" Width="200px" Height="150px" Style="background-color: #FFFFCC"></telerik:RadListBox>

                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>

                                            </tr>
                                        </table>

                                        <table runat="server" id="GRE_LAMINATION" visible="false">



                                            <tr>

                                                <td>
                                                    <telerik:RadTextBox ID="txtLamRep" runat="server" Width="200px" EmptyMessage="Lamination Rep No"></telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtLamRep"
                                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>

                                                <td>
                                                    <telerik:RadDatePicker ID="txtLamDate" runat="server" Width="200px" DateInput-EmptyMessage="Lamination Date">
                                                        <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                                        <Calendar runat="server">
                                                            <SpecialDays>
                                                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                </telerik:RadCalendarDay>
                                                            </SpecialDays>
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtLamDate"
                                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>


                                            <tr>

                                                <td>
                                                    <telerik:RadTextBox ID="txtLamHeatNo1" runat="server" AutoPostBack="true" EmptyMessage="Enter HeatNo-1" Width="200px"></telerik:RadTextBox>
                                                </td>


                                                <td>
                                                    <telerik:RadTextBox ID="txtLamHeatNo2" runat="server" AutoPostBack="true" EmptyMessage="Enter HeatNo-2" Width="200px"></telerik:RadTextBox>
                                                </td>
                                            </tr>

                                            <tr>

                                                <td>
                                                    <telerik:RadTextBox ID="txtLamTHK" runat="server" AutoPostBack="true" EmptyMessage="Enter THK" Width="200px"></telerik:RadTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <telerik:RadButton ID="btnLamination" runat="server" OnClick="btnLamination_Click" Text="Save"></telerik:RadButton>
                                                </td>
                                            </tr>
                                        </table>
                                        <table runat="server" id="Bonding" visible="false">


                                            <tr>

                                                <td>
                                                    <telerik:RadTextBox ID="txtBondingRep" runat="server" Width="200px" EmptyMessage="Bonding Rep No"></telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtBondingRep"
                                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>


                                                <td>
                                                    <telerik:RadDatePicker ID="txtBondingDate" runat="server" Width="200px" DateInput-EmptyMessage="Bonding Date">
                                                        <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                                        <Calendar runat="server">
                                                            <SpecialDays>
                                                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                </telerik:RadCalendarDay>
                                                            </SpecialDays>
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtBondingDate"
                                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>


                                            <tr>

                                                <td>
                                                    <telerik:RadTextBox ID="txtBondingName" runat="server" AutoPostBack="true" EmptyMessage="Enter Bonder Name" Width="200px"></telerik:RadTextBox>
                                                </td>

                                                <td>
                                                    <telerik:RadDatePicker ID="txtCuringDate" runat="server" Width="200px" DateInput-EmptyMessage="Curing Date">
                                                        <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                                        <Calendar runat="server">
                                                            <SpecialDays>
                                                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                                                </telerik:RadCalendarDay>
                                                            </SpecialDays>
                                                        </Calendar>
                                                    </telerik:RadDatePicker>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtBondingDate"
                                                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <telerik:RadButton ID="btnBonding" runat="server" OnClick="btnBonding_Click" Text="Save"></telerik:RadButton>
                                                </td>
                                            </tr>
                                        </table>
                                        <table runat="server" id="Nde_hide" visible="false">


                                            <tr>
                                                <td>
                                                    <telerik:RadComboBox ID="RadComNdeReq" runat="server" Width="200px" DataSourceID="NdeReqDataSource"
                                                        DataTextField="NDE_REQ_NO" DataValueField="NDE_REQ_ID" Filter="Contains" AllowCustomText="true"
                                                        AutoPostBack="true" CausesValidation="false" EmptyMessage="NDT Request" DropDownWidth="250px" Height="200px">
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="ImageNdeNew" runat="server" ImageUrl="~/Images/icons/add-blue.png" ToolTip="New NDT" CausesValidation="false" />

                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <telerik:RadButton ID="btnNdtJointAdd" runat="server" Text="Add Joint" Width="80px" OnClick="btnNdtJointAdd_Click"></telerik:RadButton>
                                                    <telerik:RadButton ID="btnNdtUpdate" runat="server" Text="Update" Width="80px" OnClick="btnNdtUpdate_Click"></telerik:RadButton>
                                                    <telerik:RadButton ID="DeleteNdtJoint" runat="server" Text="Delete" Width="60" OnClick="DeleteNdtJoint_Click" OnClientClicking="onNdtJointDelete"></telerik:RadButton>
                                                </td>
                                                <td>
                                                    <telerik:RadButton ID="NdtSegments" runat="server" Text="Segment" Width="80px" OnClick="NdtSegments_Click"></telerik:RadButton>
                                                </td>

                                            </tr>
                                        </table>
                                    </li>

                                    <li class="lastLi">

                                        <div>
                                            <asp:DetailsView ID="jointDetailsView" runat="server" AutoGenerateRows="False" CaptionAlign="Left"
                                                DataSourceID="jointDetailsDataSource1" Width="400px" HorizontalAlign="Right" Font-Size="10pt" Font-Names="Calibri"
                                                CssClass="DataWebControlStyle" GridLines="None" ForeColor="#333333">
                                                <Fields>
                                                    <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric" SortExpression="ISO_TITLE1" />
                                                    <asp:BoundField DataField="ISO_REV" HeaderText="Isometric Rev" SortExpression="ISO_REV" />
                                                    <asp:BoundField DataField="JC_REV" HeaderText="JobCard Rev" SortExpression="JC_REV" />
                                                    <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                                                    <asp:BoundField DataField="SPOOL" HeaderText="Spool Piece" SortExpression="SPOOL" />
                                                    <asp:BoundField DataField="WO_NAME" HeaderText="Job Card Number" SortExpression="WO_NAME" />
                                                    <asp:BoundField DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" />
                                                    <asp:BoundField DataField="CRW_CODE" HeaderText="CR" SortExpression="CRW_CODE" />
                                                    <asp:BoundField DataField="REV_CODE" HeaderText="Rev Code" SortExpression="REV_CODE" />
                                                    <asp:BoundField DataField="JOINT_TYPE" HeaderText="Joint Type" SortExpression="JOINT_TYPE" />
                                                    <asp:BoundField DataField="JOINT_SIZE" HeaderText="Joint Size" SortExpression="JOINT_SIZE" />
                                                    <asp:BoundField DataField="LINE_CLASS" HeaderText="Line Class" SortExpression="LINE_CLASS" />
                                                    <asp:BoundField DataField="MAT_TYPE" HeaderText="Mat Type" SortExpression="MAT_TYPE" />
                                                    <asp:BoundField DataField="JOINT_THK" HeaderText="Thickness" SortExpression="JOINT_THK" />
                                                    <asp:BoundField DataField="HEAT_NO1" HeaderText="Heat Number 1" SortExpression="HEAT_NO1" />
                                                    <asp:BoundField DataField="HEAT_NO2" HeaderText="Heat Number 2" SortExpression="HEAT_NO2" />
                                                    <asp:BoundField DataField="TRACER" HeaderText="Tracer" SortExpression="TRACER" />
                                                    <asp:BoundField DataField="DIS_FLG" HeaderText="Dissimilar (Y/N)" SortExpression="DIS_FLG" />

                                                    <asp:BoundField DataField="FITUP_DATE" DataFormatString="{0:dd-MMM-yy}" HeaderText="Fitup Date"
                                                        HtmlEncode="False" SortExpression="FITUP_DATE" />
                                                    <asp:BoundField DataField="FITUP_REP_NO" HeaderText="Fitup Rep No" SortExpression="FITUP_REP_NO" />
                                                    <asp:BoundField DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yy}" HeaderText="Weld Date"
                                                        HtmlEncode="False" SortExpression="WELD_DATE" />
                                                    <asp:BoundField DataField="WELD_REP_NO" HeaderText="Weld Rep No" SortExpression="WELD_REP_NO" />
                                                    <asp:BoundField DataField="WPS_NO" HeaderText="WPS" SortExpression="WPS_NO" />
                                                    <asp:BoundField DataField="ROOT_HOT_WELDER" HeaderText="Root/Hot" SortExpression="ROOT_HOT_WELDER" />
                                                    <asp:BoundField DataField="FILL_CAP_WELDER" HeaderText="Fill/Cap" SortExpression="FILL_CAP_WELDER" />
                                                    <asp:BoundField DataField="FITUP_INSP" HeaderText="Fitup Inspector" SortExpression="FITUP_INSP" />
                                                    <asp:BoundField DataField="WELD_INSP" HeaderText="Weld Inspector" SortExpression="WELD_INSP" />
                                                    <asp:BoundField DataField="CAT_NAME" HeaderText="Category" SortExpression="CAT_NAME" />
                                                    <asp:BoundField DataField="COMMODITY1" HeaderText="Mat Code 1" SortExpression="COMMODITY1" />
                                                    <asp:BoundField DataField="COMMODITY2" HeaderText="Mat Code 2" SortExpression="COMMODITY2" />
                                                    <asp:BoundField DataField="TW_FLG" HeaderText="TW FLG" SortExpression="TW_FLG" />
                                                    <asp:BoundField DataField="SPL_SWN_DT" HeaderText="Spool SWN Date" SortExpression="SPL_SWN_DT"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                                                    <asp:BoundField DataField="SPL_REL_DT" HeaderText="Spool Release Date" SortExpression="SPL_REL_DT"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                                                    <asp:BoundField DataField="LAMINAT_REP_NO" HeaderText="Lamination Rep No" SortExpression="LAMINAT_REP_NO" />
                                                    <asp:BoundField DataField="LAMINAT_DATE" DataFormatString="{0:dd-MMM-yy}" HeaderText="Lamination Date"
                                                        HtmlEncode="False" SortExpression="LAMINAT_DATE" />
                                                    <asp:BoundField DataField="LAMINAT_THK" HeaderText="Lamination THK" SortExpression="LAMINAT_THK" />
                                                    <asp:BoundField DataField="BONDING_REP_NO" HeaderText="Bonding Rep No" SortExpression="BONDING_REP_NO" />
                                                    <asp:BoundField DataField="BONDING_DATE" DataFormatString="{0:dd-MMM-yy}" HeaderText="Bonding Date"
                                                        HtmlEncode="False" SortExpression="BONDING_DATE" />
                                                    <asp:BoundField DataField="BONDER_NAME" HeaderText="Bonder Name" SortExpression="BONDER_NAME" />
                                                </Fields>
                                                <EmptyDataTemplate>
                                                    <label style="color: Red; font-weight: bold">Select a joint to get its' details !</label>
                                                </EmptyDataTemplate>
                                                <EmptyDataRowStyle />
                                                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                                                <EditRowStyle BackColor="#2461BF" />
                                                <FieldHeaderStyle Width="120px" BackColor="#DEE8F5" Font-Bold="True" />
                                                <AlternatingRowStyle CssClass="AlternatingRowStyle" BackColor="White" />
                                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                <RowStyle BackColor="#EFF3FB" Height="10px" />
                                            </asp:DetailsView>

                                        </div>
                                        <div>
                                            <asp:DetailsView ID="NdeDetailsView" runat="server" AllowPaging="True" AutoGenerateRows="False" SkinID="DetailsViewSkin"
                                                DataSourceID="ndeDetailsDataSource" Height="50px" Width="450px" Visible="false">
                                                <EmptyDataTemplate>
                                                    <h3>No NDT Records </h3>
                                                </EmptyDataTemplate>
                                                <PagerStyle Font-Bold="True" ForeColor="DarkGreen" />
                                                <PagerSettings Position="TopAndBottom" />
                                                <Fields>
                                                    <asp:BoundField DataField="REWORK_CODE" HeaderText="Repair Code" SortExpression="REWORK_CODE" />
                                                    <asp:BoundField DataField="RT_REQ_NO" HeaderText="RT Request No" SortExpression="RT_REQ_NO" />
                                                    <asp:BoundField DataField="RT_REP_NO" HeaderText="RT Report No" SortExpression="RT_REP_NO" />
                                                    <asp:BoundField DataField="RT_DATE" HeaderText="RT Date" SortExpression="RT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="RT_PASS_FLG" HeaderText="RT Pass Flag" SortExpression="RT_PASS_FLG" />
                                                    <asp:BoundField DataField="PT_REQ_NO" HeaderText="PT Request No" SortExpression="PT_REQ_NO" />
                                                    <asp:BoundField DataField="PT_REP_NO" HeaderText="PT Report No" SortExpression="PT_REP_NO" />
                                                    <asp:BoundField DataField="PT_DATE" HeaderText="PT Date" SortExpression="PT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="MT_REQ_NO" HeaderText="MT Request No" SortExpression="MT_REQ_NO" />
                                                    <asp:BoundField DataField="MT_REP_NO" HeaderText="MT Report No" SortExpression="MT_REP_NO" />
                                                    <asp:BoundField DataField="MT_DATE" HeaderText="MT Date" SortExpression="MT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="PMI_REQ_NO" HeaderText="PMI Request No" SortExpression="PMI_REQ_NO" />
                                                    <asp:BoundField DataField="PMI_REP_NO" HeaderText="PMI Report No" SortExpression="PMI_REP_NO" />
                                                    <asp:BoundField DataField="PMI_DATE" HeaderText="PMI Date" SortExpression="PMI_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="FT_REQ_NO" HeaderText="FT Request No" SortExpression="FT_REQ_NO" />
                                                    <asp:BoundField DataField="FT_REP_NO" HeaderText="FT Report No" SortExpression="FT_REP_NO" />
                                                    <asp:BoundField DataField="FT_DATE" HeaderText="FT Date" SortExpression="FT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="PWHT_REQ_NO" HeaderText="PWHT Requets No" SortExpression="PWHT_REQ_NO" />
                                                    <asp:BoundField DataField="PWHT_REP_NO" HeaderText="PWHT Report No" SortExpression="PWHT_REP_NO" />
                                                    <asp:BoundField DataField="PWHT_DATE" HeaderText="PWHT Date" SortExpression="PWHT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="HT_REQ_NO" HeaderText="HT Request No" SortExpression="HT_REQ_NO" />
                                                    <asp:BoundField DataField="HT_REP_NO" HeaderText="HT Report No" SortExpression="HT_REP_NO" />
                                                    <asp:BoundField DataField="HT_DATE" HeaderText="HT Date" SortExpression="HT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="PAUT_REQ_NO" HeaderText="PAUT Request No" SortExpression="PAUT_REQ_NO" />
                                                    <asp:BoundField DataField="PAUT_REP_NO" HeaderText="PAUT Report No" SortExpression="PAUT_REP_NO" />
                                                    <asp:BoundField DataField="PAUT_DATE" HeaderText="PAUT Date" SortExpression="PAUT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="PAUT_PASS_FLG" HeaderText="PAUT Pass Flag" SortExpression="PAUT_PASS_FLG" />
                                                    <asp:BoundField DataField="UT_REQ_NO" HeaderText="UT Request No" SortExpression="UT_REQ_NO" />
                                                    <asp:BoundField DataField="UT_REP_NO" HeaderText="UT Report No" SortExpression="UT_REP_NO" />
                                                    <asp:BoundField DataField="UT_DATE" HeaderText="UT Date" SortExpression="UT_DATE"
                                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="False" />
                                                    <asp:BoundField DataField="UT_PASS_FLG" HeaderText="UT Pass Flag" SortExpression="UT_PASS_FLG" />
                                                </Fields>
                                            </asp:DetailsView>
                                        </div>

                                    </li>
                                </ul>
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </ContentTemplate>
                </telerik:RadPanelItem>
                <telerik:RadPanelItem Text="Joints Details" Expanded="false">
                    <ContentTemplate>

                        <div style="width: 100%; height: 100%">
                            <telerik:RadGrid ID="JointRadGrid" runat="server" AllowPaging="True" AllowFilteringByColumn="true" AutoGenerateColumns="False" DataSourceID="GridJointDataSource" PageSize="30"
                                OnDeleteCommand="JointRadGrid_DeleteCommand" OnItemDataBound="JointRadGrid_ItemDataBound" PagerStyle-AlwaysVisible="true"
                                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" Height="99%" Width="99%">
                                <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                </ClientSettings>
                                <ClientSettings AllowKeyboardNavigation="true">
                                    <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                                        AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                                </ClientSettings>
                                <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" DataSourceID="GridJointDataSource"
                                    PageSize="30" DataKeyNames="JOINT_ID" ClientDataKeyNames="JOINT_ID" TableLayout="Fixed" CommandItemDisplay="Top"
                                    AllowPaging="true" PagerStyle-AlwaysVisible="true">
                                    <CommandItemSettings ShowAddNewRecordButton="false" />
                                    <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                                    <Columns>

                                        <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                            UniqueName="DeleteColumn">
                                            <ItemStyle Width="30px" />
                                            <HeaderStyle Width="30px" />
                                        </telerik:GridButtonColumn>

                                        <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="FITUP PDF">
                                            <ItemTemplate>
                                                <asp:Label ID="fituppdf" runat="server" Text=""></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="WELD PDF">
                                            <ItemTemplate>
                                                <asp:Label ID="weldpdf" runat="server" Text=""></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="50px" />
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="SHEET" FilterControlAltText="Filter SHEET column" HeaderText="Sheet" SortExpression="SHEET" UniqueName="SHEET" AllowFiltering="false">
                                            <ItemStyle Width="60px" />
                                            <HeaderStyle Width="60px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="Spool" SortExpression="SPOOL" UniqueName="SPOOL" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="JOINT_NO" FilterControlAltText="Filter JOINT_NO column" HeaderText="Joint No" SortExpression="JOINT_NO" UniqueName="JOINT_NO" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="JNT_REV_CODE" FilterControlAltText="Filter JNT_REV_CODE column" HeaderText="Rev Code" SortExpression="JNT_REV_CODE" UniqueName="JNT_REV_CODE" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CRW_CODE" ReadOnly="true" FilterControlAltText="Filter CRW_CODE column" HeaderText="CRW Code" SortExpression="CRW_CODE" UniqueName="CRW_CODE" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="JOINT_TYPE" FilterControlAltText="Filter JOINT_TYPE column" HeaderText="Type" SortExpression="JOINT_TYPE" UniqueName="JOINT_TYPE" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="JOINT_SIZE" FilterControlAltText="Filter JOINT_SIZE column" HeaderText="Size" SortExpression="JOINT_SIZE" UniqueName="JOINT_SIZE" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="JOINT_THK" DataType="System.Decimal" FilterControlAltText="Filter JOINT_THK column" HeaderText="Thk MM" SortExpression="JOINT_THK" UniqueName="JOINT_THK" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FITUP_REP_NO" FilterControlAltText="Filter FITUP_REP_NO column" HeaderText="FITUP REPORT" SortExpression="FITUP_REP_NO" UniqueName="FITUP_REP_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Width="130px" />
                                            <HeaderStyle Width="130px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FITUP_DATE" DataType="System.DateTime" FilterControlAltText="Filter FITUP_DATE column" HeaderText="Fitup Date"
                                            SortExpression="FITUP_DATE" UniqueName="FITUP_DATE" DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Width="130px" />
                                            <HeaderStyle Width="130px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="WELD_REP_NO" FilterControlAltText="Filter WELD_REP_NO column" HeaderText="WELD REPORT" SortExpression="WELD_REP_NO" UniqueName="WELD_REP_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Width="130px" />
                                            <HeaderStyle Width="130px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="WELD_DATE" DataType="System.DateTime" FilterControlAltText="Filter WELD_DATE column" HeaderText="Weld Date"
                                            SortExpression="WELD_DATE" UniqueName="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Width="130px" />
                                            <HeaderStyle Width="130px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="CAT_NAME" FilterControlAltText="Filter CAT_NAME column" HeaderText="Category" SortExpression="CAT_NAME" UniqueName="CAT_NAME" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="HEAT_NO1" FilterControlAltText="Filter HEAT_NO1 column" HeaderText="Heat No1" SortExpression="HEAT_NO1" UniqueName="HEAT_NO1" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="HEAT_NO2" FilterControlAltText="Filter HEAT_NO2 column" HeaderText="Heat No2" SortExpression="HEAT_NO2" UniqueName="HEAT_NO2" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="Item Code1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Width="150px" />
                                            <HeaderStyle Width="150px" />
                                            <ItemStyle Font-Size="X-Small" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="MAT_CODE2" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="Item Code2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Font-Size="X-Small" />
                                            <ItemStyle Width="150px" />
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="LAMINAT_REP_NO" FilterControlAltText="Filter LAMINAT_REP_NO column" HeaderText="LAMINATION REPORT" SortExpression="LAMINAT_REP_NO" UniqueName="LAMINAT_REP_NO" AllowFiltering="false">
                                            <ItemStyle Width="150px" />
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="LAMINAT_DATE" FilterControlAltText="Filter LAMINAT_DATE column" HeaderText="LAMINATION DATE" SortExpression="LAMINAT_DATE" UniqueName="LAMINAT_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yy}" AllowFiltering="false">
                                            <ItemStyle Width="150px" />
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="LAMINAT_THK" FilterControlAltText="Filter LAMINAT_THK column" HeaderText="LAMINATION THK" SortExpression="LAMINAT_THK" UniqueName="LAMINAT_THK" AllowFiltering="false">
                                            <ItemStyle Width="120px" />
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BONDING_REP_NO" FilterControlAltText="Filter BONDING_REP_NO column" HeaderText="BONDING REPORT" SortExpression="BONDING_REP_NO" UniqueName="BONDING_REP_NO" AllowFiltering="false">
                                            <ItemStyle Width="150px" />
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BONDING_DATE" FilterControlAltText="Filter BONDING_DATE column" HeaderText="BONDING DATE" SortExpression="BONDING_DATE" UniqueName="BONDING_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yy}" AllowFiltering="false">
                                            <ItemStyle Width="150px" />
                                            <HeaderStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="BONDER_NAME" FilterControlAltText="Filter BONDER_NAME column" HeaderText="BONDER NAME" SortExpression="BONDER_NAME" UniqueName="BONDER_NAME" AllowFiltering="false">
                                            <ItemStyle Width="180px" />
                                            <HeaderStyle Width="180px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="CURING_DATE" FilterControlAltText="Filter CURING_DATE column" HeaderText="CURING DATE" SortExpression="CURING_DATE" UniqueName="CURING_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yy}" AllowFiltering="false">
                                            <ItemStyle Width="100px" />
                                            <HeaderStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                    </Columns>
                                    <EditFormSettings>
                                        <PopUpSettings Modal="True" />
                                    </EditFormSettings>
                                </MasterTableView>
                                <GroupingSettings CaseSensitive="false" />
                            </telerik:RadGrid>
                        </div>
                    </ContentTemplate>
                </telerik:RadPanelItem>
                <telerik:RadPanelItem Text="Bom Details" Expanded="false">
                    <ContentTemplate>

                        <div style="width: 100%; height: 100%">
                            <telerik:RadGrid ID="BomRadGrid" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="GridBOMDataSource"
                                OnDeleteCommand="BomRadGrid_DeleteCommand" PageSize="30" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true"
                                EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" Width="99%" Height="99%"
                                OnEditCommand="BomRadGrid_EditCommand" CellSpacing="-1" AllowMultiColumnSorting="true">
                                <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ClientSettings>
                                    <Selecting AllowRowSelect="True" />
                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                </ClientSettings>
                                <ClientSettings AllowKeyboardNavigation="true">
                                    <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                                        AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                                </ClientSettings>
                                <ClientSettings>
                                    <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                                </ClientSettings>

                                <MasterTableView AllowAutomaticUpdates="true" DataKeyNames="BOM_ID" DataSourceID="GridBOMDataSource" ClientDataKeyNames="ISO_ID,BOM_ID"
                                    EditFormSettings-PopUpSettings-Modal="true" EditMode="InPlace" HierarchyLoadMode="Client" PageSize="30"
                                    TableLayout="Fixed" AllowFilteringByColumn="true" AllowMultiColumnSorting="true" CommandItemDisplay="Top">
                                    <CommandItemSettings ShowAddNewRecordButton="false" />
                                    <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                                    <Columns>
                                        <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                                            <ItemStyle Width="50px" />
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridEditCommandColumn>

                                        <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                            UniqueName="DeleteColumn" ItemStyle-Width="20px">
                                            <ItemStyle Width="50px" />
                                            <HeaderStyle Width="50px" />
                                        </telerik:GridButtonColumn>

                                        <telerik:GridBoundColumn DataField="SHEET" FilterControlAltText="Filter SHEET column" HeaderText="Sheet" SortExpression="SHEET" UniqueName="SHEET" ReadOnly="true" AllowFiltering="false">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SPOOL" FilterControlAltText="Filter SPOOL column" HeaderText="Spool" SortExpression="SPOOL" UniqueName="SPOOL" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="WO_NAME" HeaderText="Shop/Site JC" SortExpression="WO_NAME" UniqueName="WO_NAME" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Width="120px" />
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn DataField="PT_NO" FilterControlAltText="Filter PT_NO column" HeaderText="PT No" SortExpression="PT_NO" UniqueName="PT_NO" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemTemplate>
                                                <asp:Label ID="Label_PT_NO" runat="server" Text='<%# Bind("PT_NO") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox_PT_NO" runat="server" Text='<%# Bind("PT_NO") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="Item Code" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="MAT_CODE1TextBox" runat="server" Text='<%# Bind("MAT_CODE1") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="Mat_Code1Link" runat="server" Text='<%# Eval("MAT_CODE1") %>' OnClick="Mat_Code1Link_Click"></asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle Width="120px" />
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter Item column" HeaderText="ITEM_NAM" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                            <ItemStyle Width="120px" />
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn DataField="SF_FLG" FilterControlAltText="Filter SF_FLG column" HeaderText="SF" SortExpression="SF_FLG" UniqueName="SF_FLG" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemTemplate>
                                                <asp:Label ID="LabelSF_FLG" runat="server" Text='<%# Bind("SF_FLG") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlEditSF" runat="server" DataSourceID="sfDataSource" DataTextField="CAT_NAME" DataValueField="CAT_ID" DropDownHeight="100px" DropDownWidth="200px"
                                                    SelectedValue='<%# Bind("SF") %>'>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="REV_CODE" FilterControlAltText="Filter REV_CODE column" HeaderText="BOM REV" SortExpression="REV_CODE" UniqueName="REV_CODE" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemTemplate>
                                                <asp:Label ID="LabelADD_REV_DESC" runat="server" Text='<%# Bind("REV_CODE") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <telerik:RadDropDownList ID="ddlEditRev" runat="server" DataSourceID="sqlBOMRevSource" DataTextField="REV_CODE" DataValueField="ADD_REV_ID" DropDownHeight="100px" DropDownWidth="200px"
                                                    SelectedValue='<%# Bind("ADD_REV_ID") %>'>
                                                </telerik:RadDropDownList>
                                            </EditItemTemplate>
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="NET_QTY" FilterControlAltText="Filter NET_QTY column" HeaderText="Qty" SortExpression="NET_QTY" UniqueName="NET_QTY" AllowFiltering="false">
                                            <ItemTemplate>
                                                <asp:Label ID="Label_NET_QTY" runat="server" Text='<%# Bind("NET_QTY") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox_NET_QTY" runat="server" Text='<%# Bind("NET_QTY") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="Size" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" ReadOnly="true" AllowFiltering="false">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="Wall Thk" SortExpression="WALL_THK" UniqueName="WALL_THK" ReadOnly="true" AllowFiltering="false">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="AVAILABLE" FilterControlAltText="Filter AVAILABLE column" HeaderText="Avail." SortExpression="AVAILABLE" UniqueName="AVAILABLE" ReadOnly="true" AllowFiltering="false">
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn DataField="PAINT_CODE" FilterControlAltText="Filter PAINT_CODE column" HeaderText="Paint Code" SortExpression="PAINT_CODE" UniqueName="PAINT_CODE" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemTemplate>
                                                <asp:Label ID="Label_PAINT_CODE" runat="server" Text='<%# Bind("PAINT_CODE") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox_PAINT_CODE" runat="server" Text='<%# Bind("PAINT_CODE") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="MAT_CLASS" FilterControlAltText="Filter MAT_CLASS column" HeaderText="Mat Class" SortExpression="MAT_CLASS" UniqueName="MAT_CLASS" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemTemplate>
                                                <asp:Label ID="Label_MAT_CLASS" runat="server" Text='<%# Bind("MAT_CLASS") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox_MAT_CLASS" runat="server" Text='<%# Bind("MAT_CLASS") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="Heat No" SortExpression="HEAT_NO" UniqueName="HEAT_NO" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                            <ItemTemplate>
                                                <asp:Label ID="Label_HEAT_NO" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox_HEAT_NO" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <ItemStyle Width="80px" />
                                            <HeaderStyle Width="80px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                                            <ItemStyle Width="120px" />
                                            <HeaderStyle Width="120px" />
                                        </telerik:GridBoundColumn>

                                    </Columns>
                                    <EditFormSettings>
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                                        </EditColumn>
                                        <PopUpSettings Modal="True" />
                                    </EditFormSettings>
                                </MasterTableView>
                                <GroupingSettings CaseSensitive="false" />
                            </telerik:RadGrid>
                        </div>
                    </ContentTemplate>
                </telerik:RadPanelItem>
            </Items>
        </telerik:RadPanelBar>
    </div>




    <asp:SqlDataSource ID="IsoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT  ISO_TITLE1, ISO_ID 
                        FROM  PIP_ISOMETRIC"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SplDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT  SPOOL, SPL_ID 
                        FROM  PIP_SPOOL WHERE ISO_ID =:ISO_ID ORDER BY SPOOL">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" ControlID="ddlIsometric" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="JointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT  JOINT_NO||'/'||CRW_CODE AS JOINT_NO, JOINT_ID 
                        FROM  PIP_SPOOL_JOINTS WHERE ISO_ID =:ISO_ID  AND (SPL_ID = :SPL_ID OR :SPL_ID = -1)  ORDER BY JOINT_NO">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" ControlID="ddlIsometric" Type="String" />
            <asp:ControlParameter DefaultValue="-1" Name="SPL_ID" PropertyName="SelectedValue" ControlID="ddlSpool" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="BomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT  PT_NO, BOM_ID 
                        FROM  PIP_BOM WHERE ISO_ID =:ISO_ID  AND (SPL_ID = :SPL_ID OR :SPL_ID = -1) ORDER BY PT_NO">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" ControlID="ddlIsometric" Type="String" />
            <asp:ControlParameter DefaultValue="-1" Name="SPL_ID" PropertyName="SelectedValue" ControlID="ddlSpool" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="TransCatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT CAT_ID, TRANS_CAT AS CATEGORY,ORDER_A FROM  PIP_SPOOL_TRANS_CAT WHERE CAT_ID IN(5,8,10,12,13,14,16)
                       UNION SELECT 100 AS CAT_ID,'SPOOL JOBCARD' AS CATEGORY,0.1 AS ORDER_A FROM DUAL 
                       UNION SELECT 101 AS CAT_ID,'SPOOL PAINTING' AS CATEGORY,0.2 AS ORDER_A  FROM DUAL 
                      ORDER BY ORDER_A "></asp:SqlDataSource>

    <asp:HiddenField ID="HiddenStoreID" runat="server" />
    <asp:SqlDataSource ID="dsSubStore" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM AMOGH.STORES_SUB WHERE STORE_ID = :STORE_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenStoreID" DefaultValue="-1" Name="STORE_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="JointActivityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT 1 AS CAT_ID, 'Fitup' AS CATEGORY FROM  DUAL
                       UNION SELECT 2 AS CAT_ID,'Welding' AS CATEGORY FROM DUAL 
                       UNION SELECT 3 AS CAT_ID,'Lamination' AS CATEGORY FROM DUAL 
                       UNION SELECT 4 AS CAT_ID,'Bonding' AS CATEGORY FROM DUAL 
                       UNION SELECT 5 AS CAT_ID,'NDT' AS CATEGORY FROM DUAL "></asp:SqlDataSource>

    <asp:HiddenField ID="pipeMatId1Field" runat="server" />
    <asp:HiddenField ID="pipeMatId2Field" runat="server" />
    <asp:HiddenField ID="bomId1Field" runat="server" />
    <asp:HiddenField ID="bomId2Field" runat="server" />
    <asp:HiddenField ID="IsoIdField" runat="server" />
    <asp:HiddenField ID="hnTypeField" runat="server" />
    <asp:HiddenField ID="unqPartField" runat="server" />
    <asp:HiddenField ID="weldProcessCtrlField" runat="server" />
    <asp:HiddenField ID="hiddenMat1" runat="server" />
    <asp:HiddenField ID="hiddenMat2" runat="server" />

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE EXISTS 
        ( SELECT * FROM 
            ( SELECT
              CASE WHEN (CAT_ID = 1 OR  CAT_ID = 3)   AND WO_ID IS NOT NULL
                   THEN SC_ID 
                   WHEN (CAT_ID = 2 OR CAT_ID = 4)
                   THEN  FIELD_SC_ID END AS SUB_CON_ID
              FROM VIEW_ADAPTER_JOINTS
             WHERE JOINT_ID=  :JOINT_ID                   
             AND  JNT_REV_CODE  NOT  IN  ('D','N')) WHERE SUB_CON_ID = SUB_CONTRACTOR.SUB_CON_ID)">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="JOINT_ID" ControlID="ddlJoint" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="itemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ISO_TITLE1||'/'||PT_NO ITEM,BOM_ID FROM VIEW_ISO_BOM_LINK"></asp:SqlDataSource>

    <asp:SqlDataSource ID="WeldPassDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PASS_ID, WELD_PASS FROM PIP_WELDING_PASS ORDER BY PASS_ID"></asp:SqlDataSource>



    <asp:SqlDataSource ID="jointDetailsDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>

    <asp:SqlDataSource ID="HeatNo1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT HEAT_NO FROM VIEW_MRIR_HN
                       WHERE MAT_ID=(SELECT A.MAT_ID FROM PIP_BOM A WHERE A.BOM_ID= (SELECT J.ITEM_1  FROM PIP_SPOOL_JOINTS J WHERE J.JOINT_ID=:JOINT_ID))
                      ">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="JOINT_ID" ControlID="ddlJoint" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="HeatNo2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT HEAT_NO FROM VIEW_MRIR_HN WHERE (MAT_ID = (SELECT MAT_ID FROM PIP_BOM A WHERE (BOM_ID = (SELECT ITEM_2 FROM PIP_SPOOL_JOINTS J WHERE (JOINT_ID = :JOINT_ID)))))">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="JOINT_ID" ControlID="ddlJoint" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="NdeReqDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT NDE_REQ_ID, NDE_REQ_NO FROM PIP_NDE_REQUEST "></asp:SqlDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SPL_ID, SHEET_SPOOL FROM VIEW_SPOOL_TITLE WHERE (ISO_ID = :ISO_ID) ORDER BY SHEET_SPOOL'>
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" ControlID="ddlIsometric" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="GridJointDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT  *  FROM VIEW_ADAPTER_JOINTS 
                        WHERE (ISO_ID = :ISO_ID) AND (SPL_ID = :SPL_ID OR :SPL_ID = -1)
                        ORDER BY FNC_JNT_NO_DEC(JOINT_NO), JOINT_NO, SEC_KEY"
        DeleteCommand="DELETE FROM PIP_SPOOL_JOINTS WHERE (JOINT_ID = :JOINT_ID)">

        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" ControlID="ddlIsometric" Type="String" />
            <asp:ControlParameter DefaultValue="-1" Name="SPL_ID" PropertyName="SelectedValue" ControlID="ddlSpool" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="JOINT_ID" Type="Decimal" />
        </DeleteParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="GridBOMDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT  *  FROM VIEW_ADAPTER_BOM 
                        WHERE (ISO_ID = :ISO_ID) AND (SPL_ID = :SPL_ID OR :SPL_ID = -1)
                        ORDER BY PT_NO_SORT, PT_NO"
        DeleteCommand="DELETE FROM PIP_BOM WHERE (BOM_ID = :BOM_ID)"
        UpdateCommand=" UPDATE PIP_BOM
                        SET PT_NO = :PT_NO, SF = :SF, NET_QTY = :NET_QTY, PAINT_CODE = :PAINT_CODE, MAT_CLASS = :MAT_CLASS, 
                            HEAT_NO = :HEAT_NO, REMARKS = :REMARKS, ADD_REV_ID = :ADD_REV_ID
                        WHERE (BOM_ID = :BOM_ID) ">

        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" ControlID="ddlIsometric" Type="String" />
            <asp:ControlParameter DefaultValue="-1" Name="SPL_ID" PropertyName="SelectedValue" ControlID="ddlSpool" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="BOM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PT_NO" Type="String" />
            <asp:Parameter Name="SF" Type="Decimal" />
            <asp:Parameter Name="NET_QTY" Type="Decimal" />
            <asp:Parameter Name="PAINT_CODE" Type="String" />
            <asp:Parameter Name="MAT_CLASS" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="ADD_REV_ID" Type="Decimal" />
            <asp:Parameter Name="BOM_ID" Type="Decimal" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sfDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "CAT_ID", "CAT_NAME" FROM "BOM_CATEGORY" ORDER BY "CAT_ID"'></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBOMRevSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM BOM_ADDITIONAL_REV"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ndeDetailsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT RT_REQ_ID, RT_REQ_NO,REWORK_CODE, RT_REQ_DATE, RT_REP_NO, RT_DATE, RT_PASS_FLG, RT_TOTAL_FILM, RT_ACPT_FILM, PT_REQ_NO, PT_REP_NO, PT_DATE, MT_REQ_NO, MT_REP_NO, MT_DATE, PWHT_REQ_NO, PWHT_REP_NO, PWHT_DATE, HT_REQ_NO, HT_REP_NO, HT_DATE, PMI_REQ_NO, PMI_REP_NO, PMI_DATE, FT_REQ_NO, FT_REP_NO, FT_DATE,PAUT_REQ_NO,PAUT_REP_NO,PAUT_DATE,PAUT_PASS_FLG,UT_REQ_NO,UT_REP_NO,UT_DATE,UT_PASS_FLG FROM VIEW_NDE_REPAIR_CODE WHERE (JOINT_ID = :JOINT_ID)">
        <SelectParameters>
            <asp:ControlParameter DefaultValue="-1" Name="JOINT_ID" PropertyName="SelectedValue" ControlID="ddlJoint" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

