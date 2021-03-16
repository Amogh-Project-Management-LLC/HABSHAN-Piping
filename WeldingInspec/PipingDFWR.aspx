<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"
    CodeFile="PipingDFWR.aspx.cs" Inherits="WeldingInspec_PipingDFWR" Title="Fitup Welding Entry" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>




<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="padding: 3px; background-color: whitesmoke;">
        <%--  <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>--%>
        <%--<telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>--%>
        <telerik:RadButton ID="btnDFR" runat="server" Text="Bulk Fitup" Width="80" OnClick="btnDFR_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnDWR" runat="server" Text="Bulk Welding" Width="100" OnClick="btnDWR_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnRepairDWR" runat="server" Text="Repair Welding" Width="120" OnClick="btnRepairDWR_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnTWEntry" runat="server" Text="Tack Weld" Width="100" OnClick="btnTWEntry_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnWeldRep" runat="server" Text="Welding Reports" Width="120" OnClick="btnWeldRep_Click" CausesValidation="false"></telerik:RadButton>
        <telerik:RadButton ID="btnWPS" runat="server" Text="WPS Update" Width="120" OnClick="btnWPS_Click" CausesValidation="false"></telerik:RadButton>
        <%--     </ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>
    <div class="right_content">
        <%--   <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>--%>
        <table style="width: 100%;">
            <tr>
                <td style="vertical-align: top">

                    <table>

                        <tr>
                            <td>
                                <telerik:RadLabel Text="Report Type" runat="server"></telerik:RadLabel>
                            </td>
                            <td>

                                <telerik:RadRadioButtonList ID="rblReportType" runat="server" Direction="Horizontal" Font-Size="10pt" Font-Names="Calibri"
                                    AutoPostBack="true" OnSelectedIndexChanged="rblReportType_SelectedIndexChanged" CausesValidation="false">
                                    <Items>
                                        <telerik:ButtonListItem Value="1" Text="Fitup" />
                                        <telerik:ButtonListItem Value="2" Text="Welding" />
                                        <telerik:ButtonListItem Value="3" Text="Lamination" />
                                        <telerik:ButtonListItem Value="4" Text="Bonding" />
                                    </Items>
                                </telerik:RadRadioButtonList>
                            </td>
                            <td>
                                <telerik:RadLabel Text="Sub Contractor" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadDropDownList runat="server" ID="ddlSubcon" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                    AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlSubcon_SelectedIndexChanged"  Width="100px" DropDownWidth="250px">
                                    <Items>
                                        <telerik:DropDownListItem Value="-1" Text="Select SubCon" Selected="true" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                    </table>

                    <table runat="server" id="Fitup_Entry" visible="false">
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblFitupReport" Text="Fitup Report" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtFitupRep" runat="server" Width="200px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFitupRep"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblFitupDate" Text="Fitup Date" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txtFitupDate" runat="server" Width="200px">
                                    <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtFitupDate"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblFitupIso" Text="Isometric" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtFitupIsometric" runat="server" AutoPostBack="true" EmptyMessage="Enter Iso_title1" Width="200px"></telerik:RadTextBox></td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblISOJnt" Text="Isometric-Joint" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbFitupJoint" Text="Select Joint" DataSourceID="FitupjointsDataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID"
                                    runat="server" AllowCustomText="true" Filter="Contains" AutoPostBack="true" Width="200px" OnSelectedIndexChanged="rcbFitupJoint_SelectedIndexChanged" CausesValidation="false">
                                </telerik:RadComboBox>
                                <asp:CompareValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="rcbFitupJoint" ValueToCompare="Select Joint" Operator="NotEqual"
                                    ErrorMessage="*" ForeColor="Red"></asp:CompareValidator>
                            </td>
                        </tr>


                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblHN1" Text="Heat No1" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbHeatNo1" runat="server" DataSourceID="HeatNo1DataSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
                                    Filter="Contains" AllowCustomText="true" Text="Select Heat No1" AutoPostBack="true"  Width="200px">
                                </telerik:RadComboBox>
                                <telerik:RadTextBox ID="txtSuppHeatNo1" runat="server" Width="200px" Visible="false"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblHN2" Text="Heat No2" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbHeatNo2" runat="server" DataSourceID="HeatNo2DataSource" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
                                    Filter="Contains" AllowCustomText="true" Text="Select Heat NO2"  Width="200px">
                                </telerik:RadComboBox>
                                <telerik:RadTextBox ID="txtSuppHeatNo2" runat="server" Visible="false" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <telerik:RadLabel ID="lblFitupInspcode" Text="Inspector Code" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadDropDownList ID="ddlFitupInspCode" runat="server" DataSourceID="FitupInspDataSource" DataTextField="INSP_CODE" DataValueField="INSP_CODE" AppendDataBoundItems="true" Width="200px">
                                    <Items>
                                        <telerik:DropDownListItem Value="" Text="Select Inspector" Selected="true" />
                                    </Items>
                                </telerik:RadDropDownList>
                            </td>
                        </tr>
                         <tr>
                            <td>
                                <telerik:RadLabel ID="lblFitupForeman" Text="Foreman" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                               <telerik:RadTextBox ID="txtFitupForeman" runat="server"></telerik:RadTextBox>
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
                                            <telerik:RadLabel ID="lblWeldIso" Text="Isometric" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtWeldIsometric" runat="server" AutoPostBack="true" EmptyMessage="Enter Iso_title1" Width="200px"></telerik:RadTextBox></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblWeldIsoJnt" Text="Isometric-Joint" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="rcbWeldIsoJnt" runat="server" AllowCustomText="true" Filter="Contains" Text="Select Joint" DataSourceID="WeldjointsDataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID"
                                                AutoPostBack="true" Width="200px" OnSelectedIndexChanged="rcbWeldIsoJnt_SelectedIndexChanged" CausesValidation="false">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblWeldWps" Text="WPS No" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="ddlWeldWps" runat="server" DataSourceID="wpsDataSource" DataTextField="WPS_NO1" DataValueField="WPS_ID"
                                                Filter="Contains" AllowCustomText="true" AutoPostBack="true" OnSelectedIndexChanged="ddlWeldWps_SelectedIndexChanged" CausesValidation="false">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Select Wps" Value="-1" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblWeldRep" Text="Weld Report No" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtWeldRepNo" runat="server"></telerik:RadTextBox>
                                            <asp:RequiredFieldValidator runat="server" ID="rfv1" ControlToValidate="txtWeldRepNo" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblWeldDate" Text="Weld Date" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="txtWeldDate" runat="server">
                                                <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="txtWeldDate" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblWeldInsp" Text="Inspector Code" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="rcbWeldInsp" runat="server" DataSourceID="WeldInspDataSource" DataTextField="INSP_CODE" DataValueField="INSP_CODE" Filter="Contains"
                                                AllowCustomText="true">
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="rcbWeldInsp" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                            <telerik:RadTextBox ID="txtJoint_size" runat="server" Visible="False"></telerik:RadTextBox>
                                            <telerik:RadTextBox ID="txtJoint_thk" runat="server" Visible="False"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblWeldInspDate" Text="Inspection Date" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="txtInspDate" runat="server">
                                                <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                            </telerik:RadDatePicker>
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="txtInspDate" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <%-- <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblConsumable" Text="Weld Consumable" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtConsumable" runat="server"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblWeldMachine" Text="Weld Machine" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtWeldMachine" runat="server"></telerik:RadTextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lbltime" Text="Shift Time" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="ddlSiftTime" runat="server">
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text="(Select)" Value="-1" />
                                                    <telerik:RadComboBoxItem runat="server" Text="DAY" Value="DAY" />
                                                    <telerik:RadComboBoxItem runat="server" Text="NIGHT" Value="NIGHT" />
                                                    <telerik:RadComboBoxItem runat="server" Text="DAY AND NIGHT" Value="DAY AND NIGHT" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>--%>
                                    <tr>
                                        <td>
                                            <telerik:RadLabel ID="lblInspResult" Text="Inspection Result" runat="server"></telerik:RadLabel>
                                        </td>
                                        <td>
                                            <telerik:RadTextBox ID="txtInspResult" runat="server"></telerik:RadTextBox>
                                        </td>
                                    </tr>
                                      <tr>
                            <td>
                                <telerik:RadLabel ID="lblWeldForeman" Text="Foreman" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                               <telerik:RadTextBox ID="txtWeldForeman" runat="server"></telerik:RadTextBox>
                            </td>
                        </tr>
                                    <%-- <tr>
                                                <td>
                                                    <telerik:RadLabel ID="lblCrew" Text="Crew Number" runat="server"></telerik:RadLabel>
                                                </td>
                                                <td>
                                                    <telerik:RadDropDownList ID="ddlCrew" runat="server" DataSourceID="sqlCrewSource" DataTextField="CREW_CODE"
                                                        DataValueField="CREW_ID" AppendDataBoundItems="true" OnSelectedIndexChanged="ddlCrew_SelectedIndexChanged">
                                                        <Items>
                                                            <telerik:DropDownListItem Text="Select Crew" Value="-1" />
                                                        </Items>
                                                    </telerik:RadDropDownList>
                                                </td>
                                            </tr>--%>
                                    <%--<tr>
                                                <td>
                                                    <telerik:RadLabel ID="RadLabel1" Text="Foreman" runat="server"></telerik:RadLabel>
                                                </td>

                                                <td>
                                                    <telerik:RadTextBox ID="txtfornam" runat="server"></telerik:RadTextBox>
                                                </td>
                                            </tr>--%>
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
                                            <td class="auto-style2">Welder</td>
                                            <td>
                                                <telerik:RadComboBox Skin="Windows7" ID="ddlWelder" runat="server" Width="150px" DataSourceID="welderDataSource" DataTextField="WELDER_NO"
                                                    DataValueField="WELDER_ID" Filter="Contains" AllowCustomText="true" AutoPostBack="true" CausesValidation="false">
                                                </telerik:RadComboBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="auto-style2">Pass</td>
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
                                                <telerik:RadListBox ID="weldersListBox" runat="server" Width="95%" Height="150px" Style="background-color: #FFFFCC"></telerik:RadListBox>

                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            
                        </tr>
                    </table>

                    <table runat="server" id="GRE_LAMINATION" visible="false">

                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel3" Text="Isometric" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtLamIso" runat="server" AutoPostBack="true" EmptyMessage="Enter Iso_title1" Width="200px"></telerik:RadTextBox></td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel4" Text="Isometric-Joint" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbLamJoint" Text="Select Joint" DataSourceID="rcbLamJointDataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID"
                                    runat="server" AllowCustomText="true" Filter="Contains" AutoPostBack="true" Width="200px" OnSelectedIndexChanged="rcbLamJoint_SelectedIndexChanged" CausesValidation="false">
                                </telerik:RadComboBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="rcbLamJoint" ValueToCompare="Select Joint" Operator="NotEqual"
                                    ErrorMessage="*" ForeColor="Red"></asp:CompareValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel1" Text="Lamination Rep No" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtLamRep" runat="server" Width="200px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtLamRep"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel2" Text="Lamination Date" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txtLamDate" runat="server" Width="200px">
                                    <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtLamDate"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>


                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel7" Text="Heat No1" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtLamHeatNo1" runat="server" AutoPostBack="true" EmptyMessage="Enter HeatNo-1" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel8" Text="Heat No2" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtLamHeatNo2" runat="server" AutoPostBack="true" EmptyMessage="Enter HeatNo-2" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel5" Text="Thickness" runat="server"></telerik:RadLabel>
                            </td>
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
                                <telerik:RadLabel ID="RadLabel6" Text="Isometric" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtBondingIso" runat="server" AutoPostBack="true" EmptyMessage="Enter Iso_title1" Width="200px"></telerik:RadTextBox></td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel9" Text="Isometric-Joint" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="rcbBondingJoint" Text="Select Joint" DataSourceID="rcbBondingDataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID"
                                    runat="server" AllowCustomText="true" Filter="Contains" AutoPostBack="true" Width="200px" OnSelectedIndexChanged="rcbBondingJoint_SelectedIndexChanged" CausesValidation="false">
                                </telerik:RadComboBox>
                                <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="rcbBondingJoint" ValueToCompare="Select Joint" Operator="NotEqual"
                                    ErrorMessage="*" ForeColor="Red"></asp:CompareValidator>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel10" Text="Bonding Rep No" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtBondingRep" runat="server" Width="200px"></telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtBondingRep"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel11" Text="Bonding Date" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txtBondingDate" runat="server" Width="200px">
                                    <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtBondingDate"
                                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                        </tr>


                        <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel14" Text="Bonder Name" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                <telerik:RadTextBox ID="txtBondingName" runat="server" AutoPostBack="true" EmptyMessage="Enter Bonder Name" Width="200px"></telerik:RadTextBox>
                            </td>
                        </tr>

                  
                          <tr>
                            <td>
                                <telerik:RadLabel ID="RadLabel12" Text="Curing Date" runat="server"></telerik:RadLabel>
                            </td>
                            <td>
                                   <telerik:RadDatePicker ID="txtCuringDate" runat="server" Width="200px">
                                    <DateInput runat="server" DateFormat="dd-MMM-yy"></DateInput>
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

                </td>
                <td style="vertical-align: top">
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
                        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                        <EditRowStyle BackColor="#2461BF" />
                        <FieldHeaderStyle Width="120px" BackColor="#DEE8F5" Font-Bold="True" />
                        <AlternatingRowStyle CssClass="AlternatingRowStyle" BackColor="White" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#EFF3FB" Height="10px" />
                    </asp:DetailsView>

                </td>

            </tr>
        </table>
        <%--   </ContentTemplate>
        </asp:UpdatePanel>--%>
        <%--    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>--%>
        <asp:HiddenField ID="pipeMatId1Field" runat="server" />
        <asp:HiddenField ID="pipeMatId2Field" runat="server" />
        <asp:HiddenField ID="bomId1Field" runat="server" />
        <asp:HiddenField ID="bomId2Field" runat="server" />
        <asp:HiddenField ID="IsoIdField" runat="server" />
        <asp:HiddenField ID="hnTypeField" runat="server" />
        <asp:HiddenField ID="unqPartField" runat="server" />
        <asp:HiddenField ID="weldProcessCtrlField" runat="server" />
        <%--      </ContentTemplate>
                </asp:UpdatePanel>--%>

        <%--   </ContentTemplate>
        </asp:UpdatePanel>--%>

        <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="FitupjointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT ISO_TITLE1||'/'||SPOOL||'/'||JOINT_NO||'/'||CRW_CODE AS JOINT_TITLE, JOINT_ID FROM VIEW_ADAPTER_JOINTS
                            WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1= :SEARCH)
                            AND (FITUP_DATE IS NULL)
                            AND (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                            OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                            AND  JNT_REV_CODE  NOT  IN  ('D','N')
                            ORDER BY ISO_ID, JOINT_TITLE">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="txtFitupIsometric" DefaultValue="~" Name="SEARCH" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="WeldjointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT ISO_TITLE1||'/'||SPOOL||'/'||JOINT_NO||'/'||CRW_CODE AS JOINT_TITLE, JOINT_ID FROM VIEW_ADAPTER_JOINTS
                            WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1= :SEARCH)
                            AND (FITUP_DATE IS NOT NULL)
                            AND (WELD_DATE IS NULL)
                            AND (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID AND WO_ID IS NOT NULL)
                            OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                            AND  JNT_REV_CODE  NOT  IN  ('D','N')
                            ORDER BY ISO_ID, JOINT_TITLE">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="txtWeldIsometric" DefaultValue="~" Name="SEARCH" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="itemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT ISO_TITLE1||'/'||PT_NO ITEM,BOM_ID FROM VIEW_ISO_BOM_LINK"></asp:SqlDataSource>

        <asp:SqlDataSource ID="HeatNo1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT DISTINCT HEAT_NO FROM VIEW_MRIR_HN
 WHERE MAT_ID=(SELECT A.MAT_ID FROM PIP_BOM A WHERE A.BOM_ID= (SELECT J.ITEM_1  FROM PIP_SPOOL_JOINTS J WHERE J.JOINT_ID=:JOINT_ID))
">
            <SelectParameters>
                <asp:ControlParameter DefaultValue="-1" Name="JOINT_ID" ControlID="rcbFitupJoint" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hiddenMat1" runat="server" />
        <asp:SqlDataSource ID="HeatNo2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT DISTINCT HEAT_NO FROM VIEW_MRIR_HN WHERE (MAT_ID = (SELECT MAT_ID FROM PIP_BOM A WHERE (BOM_ID = (SELECT ITEM_2 FROM PIP_SPOOL_JOINTS J WHERE (JOINT_ID = :JOINT_ID)))))">
            <SelectParameters>
                <asp:ControlParameter DefaultValue="-1" Name="JOINT_ID" ControlID="rcbFitupJoint" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:HiddenField ID="hiddenMat2" runat="server" />


        <asp:SqlDataSource ID="FitupInspDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT INSP_CODE FROM PIP_INSPECTOR WHERE SUB_CON_ID=:SC_ID AND TYPE_ID=1">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="welderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT WELDER_ID,WELDER_NO FROM VIEW_TOTAL_WLDR_QLF 
                             WHERE :JOINT_SIZE BETWEEN SIZE_FROM AND SIZE_TO AND :JOINT_THK BETWEEN THK_FROM AND THK_TO 
                             AND (PROJECT_ID = :PROJECT_ID)  AND (WPS_ID = :WPS_ID) ORDER BY WELDER_NO">
            <%--AND (SC_ID = :SC_ID)--%>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtJoint_size" DefaultValue="-1" Name="JOINT_SIZE" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtJoint_thk" DefaultValue="-1" Name="JOINT_THK" PropertyName="Text" />
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="ddlWeldWps" DefaultValue="-1" Name="WPS_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="WeldInspDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT INSP_CODE FROM PIP_INSPECTOR WHERE SUB_CON_ID=:SC_ID AND TYPE_ID=2">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="WeldPassDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT PASS_ID, WELD_PASS FROM PIP_WELDING_PASS ORDER BY PASS_ID"></asp:SqlDataSource>

        <asp:SqlDataSource ID="wpsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WPS_ID, WPS_NO1
                                                                                                        FROM PIP_WPS_NO
                                                                                                        WHERE (PROJECT_ID = :PROJECT_ID)                                                                                                        
                                                                                                                AND :JOINT_SIZE_DEC  BETWEEN SIZE_FROM AND SIZE_TO 
                                                                                                                AND :JOINT_THK BETWEEN THK_FROM AND THK_TO 
                                                                                                        ORDER BY WPS_NO1">
            <%--AND (SC_ID = :SC_ID)--%>
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />              
                <asp:ControlParameter ControlID="txtJoint_size" DefaultValue="-1" Name="JOINT_SIZE_DEC" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtJoint_thk" DefaultValue="-1" Name="JOINT_THK" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>


        <asp:SqlDataSource ID="sqlCrewSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT CREW_ID, CREW_CODE FROM PIP_CREW WHERE SC_ID = :SC_ID ORDER BY CREW_CODE">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="jointDetailsDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>

        <asp:SqlDataSource ID="rcbLamJointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT ISO_TITLE1||'/'||JOINT_NO||'/'||CRW_CODE AS JOINT_TITLE, JOINT_ID FROM VIEW_ADAPTER_JOINTS
                            WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1= :SEARCH)
                            AND (Laminat_rep_no IS NULL)
                             AND (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID)
                            OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                            AND JOINT_TYPE ='NM'
                            ORDER BY ISO_ID, JOINT_TITLE">

            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="txtLamIso" DefaultValue="~" Name="SEARCH" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="rcbBondingDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT ISO_TITLE1||'/'||JOINT_NO||'/'||CRW_CODE AS JOINT_TITLE, JOINT_ID FROM VIEW_ADAPTER_JOINTS
                            WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1= :SEARCH)
                            AND (Bonding_rep_no IS NULL)
                             AND (((CAT_ID = 1 OR  CAT_ID = 3) AND SC_ID = :SC_ID)
                            OR ((CAT_ID = 2 OR CAT_ID = 4) AND FIELD_SC_ID = :SC_ID))
                            AND JOINT_TYPE ='NM'
                            ORDER BY ISO_ID, JOINT_TITLE">

            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="txtBondingIso" DefaultValue="~" Name="SEARCH" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

        
    </div>
</asp:Content>
