<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolTransferNew.aspx.cs" Inherits="SpoolMove_SpoolTransferNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <div>
        <table>
            <tr>
                <td class="Heading">Transfer No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTransNo" runat="server" Width="230px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Ship No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShip" runat="server" Width="230px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Transfer Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtTransDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Transfer By
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTransBy" runat="server" Width="230px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">From Subcon
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlFromSubcon" runat="server" DataSourceID="sqlFromSubcon" DataTextField="SUB_CON_NAME"
                        DataValueField="SUB_CON_ID" OnDataBinding="ddlFromSubcon_DataBinding" AppendDataBoundItems="true"
                        AutoPostBack="true" OnSelectedIndexChanged="ddlFromSubcon_SelectedIndexChanged">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">To Subcon
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlToSubcon" runat="server" DataSourceID="sqlToSubcon" DataTextField="SUB_CON_NAME"
                        DataValueField="SUB_CON_ID" OnDataBinding="ddlToSubcon_DataBinding" AppendDataBoundItems="true" AutoPostBack="true">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td class="Heading">Reason
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlReason" runat="server" AutoPostBack="True"
                        OnSelectedIndexChanged="ddlReason_SelectedIndexChanged" DataSourceID="reasonSqlDS"
                        DataTextField="REASON_TYPE" DataValueField="RES_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:DropDownListItem />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr id="RowErectionOption" runat="server" visible="false">
                <td class="Heading">Erection Option
                </td>
                <td>
                    <telerik:RadRadioButtonList runat="server" ID="rdoErectionOption" OnSelectedIndexChanged="rdoErectionOption_SelectedIndexChanged" Direction="Horizontal">
                        <Items>
                            <telerik:ButtonListItem Text="Received at Site" Value="AT_SITE" />
                            <telerik:ButtonListItem Text="Received by Field SubCon" Value="AT_SITE_SUBCON" Selected="true" />
                        </Items>
                    </telerik:RadRadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="Heading">Document Ref No
                </td>
                <td>

                    <telerik:RadComboBox ID="ddlDocNo" runat="server" DataSourceID="sqlDocRef" DataTextField="JC_NO"
                        DataValueField="JC_ID" Width="150px" CheckBoxes="True" Filter="Contains" Height="150px" DropDownAutoWidth="Enabled" >
                    </telerik:RadComboBox>

                    <telerik:RadTextBox ID="txtDocNo" runat="server" Visible="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Container No</td>
                <td>

                    <telerik:RadTextBox ID="txtContainerNo" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="300px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="sqlFromSubcon" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlToSubcon" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDocRef" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="reasonSqlDS" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT RES_ID, REASON_TYPE FROM PIP_SPL_TRANSFER_REASON ORDER BY ORDER_INT"></asp:SqlDataSource>
</asp:Content>
