<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatExceptionRepNew.aspx.cs" Inherits="Material_MatExceptionRepNew"
    Title="ESD Register" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= entryTable.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=entryTable.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 220 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: gainsboro">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div id="entryTable" runat="server">
        <table>
            <tr>
                <td style="width: 170px; background-color: whitesmoke;">Sub Contractor</td>
                <td>
                    <telerik:RadDropDownList ID="ddlSubconList" runat="server" AutoPostBack="True" DataSourceID="sqlSubconSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnSelectedIndexChanged="ddlSubconList_SelectedIndexChanged"
                        Width="200px" AppendDataBoundItems="true" OnDataBinding="ddlSubconList_DataBinding">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr id="MatSrc" runat="server" visible="false">
                <td style="width: 170px; background-color: whitesmoke;">Material Source</td>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" AutoPostBack="true"
                        OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" Width="250px">
                        <asp:ListItem Text="MRIR" Value="MRIR"></asp:ListItem>
                        <asp:ListItem Text="TRANSFER RECEIVE" Value="MRV"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label1" runat="server" Text="ESD Report Number"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReportNo" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtReportNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label8" runat="server" Text="MRIR Number"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtSearchMIR" EmptyMessage="Search MRIR.." AutoPostBack="True" OnTextChanged="txtSearchMIR_TextChanged"></telerik:RadTextBox>
                    <telerik:RadDropDownList ID="cboMR" runat="server" AppendDataBoundItems="True" DataSourceID="mrDataSource"
                        DataTextField="MIR_NO" DataValueField="MIR_ID" Width="250px" Height="25"
                        AutoPostBack="false">
                        <Items>
                            <telerik:DropDownListItem Selected="True" Value="-1" Text="(Select One)" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="mrValidator" runat="server" ControlToValidate="cboMR" ErrorMessage="*"
                        Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr id="MRVSrc" runat="server" visible="false">
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="Label3" runat="server" Text="Transfer Receive Number"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtSearchReceive" EmptyMessage="Search Receive.." AutoPostBack="true" OnTextChanged="txtSearchReceive_TextChanged"></telerik:RadTextBox>
                    <telerik:RadDropDownList ID="ddlTransRecive" runat="server" AppendDataBoundItems="True" DataSourceID="mrvDataSource"
                        DataTextField="MAT_RCV_NO" DataValueField="MAT_RCV_ID" Width="250px" Height="25" Enabled="false">
                        <Items>
                            <telerik:DropDownListItem Selected="True" Value="-1" Text="(Select One)" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboMR" ErrorMessage="*"
                        Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Created By
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCreatedBy" runat="server" Width="200px" ReadOnly="true"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Report Date"></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtReportDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">
                    <asp:Label ID="Label7" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="background-color: gainsboro">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="mrDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MIR_ID, MIR_NO FROM PRC_MAT_INSP WHERE (PROJ_ID = :PROJECT_ID) AND (UPPER(MIR_NO) LIKE FNC_FILTER(:SEARCH)) AND MRIR_SC_ID = :SC_ID ORDER BY MIR_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtSearchMIR" DefaultValue="%" Name="SEARCH" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlSubconList" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="mrvDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_RCV_ID, MAT_RCV_NO FROM PIP_MAT_RECEIVE WHERE (PROJECT_ID = :PROJECT_ID) AND UPPER(MAT_RCV_NO) LIKE FNC_FILTER(:SEARCH) AND STORE_ID IN (SELECT SD.STORE_ID FROM STORES_DEF SD WHERE SD.SC_ID= :SC_ID) ORDER BY MAT_RCV_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtSearchReceive" DefaultValue="%" Name="SEARCH" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlSubconList" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
</asp:Content>
