<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="PaintBulkRegister.aspx.cs" Inherits="Painting_PaintBulkRegister" Title="Paint Request" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width:120px;
            padding-left:5px;
            background-color:whitesmoke;
        }
    </style>
    <div style="background-color: whitesmoke;">

        <table>
            <tr>
                
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>
            <tr>
                <td class="Heading">
                    <asp:Label ID="Label1" runat="server" Text="Issue Number"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtIssueNumber" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="issueNoValidator" runat="server" ControlToValidate="txtIssueNumber"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    <asp:Label ID="Label2" runat="server" Text="Issue Date"></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
              <tr>
                <td class="Heading">
                    <asp:Label ID="Label7" runat="server" Text="Target Date"></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtTargetDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtTargetDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
         <%--   <tr>
                <td class="Heading">Paint Code</td>
                <td>
                    <asp:DropDownList ID="ddlPaintCode" runat="server" Width="150px" DataSourceID="sqlPaintSystem" DataTextField="LINE_PS" 
                        DataValueField="LINE_PS" AppendDataBoundItems="true" OnDataBinding="ddlPaintCode_DataBinding"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="PaintCodeFieldValidator" runat="server" ControlToValidate="ddlPaintCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>--%>
         
            <tr>
                <td class="Heading">
                    <asp:Label ID="Label3" runat="server" Text="From Subcon"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cboToSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="FromSubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="135px">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboToSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
               <tr>
                <td class="Heading">
                    <asp:Label ID="Label5" runat="server" Text="To Subcon"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="ToSubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="135px" AutoPostBack="True"
                        OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="Heading">Scope</td>
                <td>
                    <asp:DropDownList ID="ddScope" runat="server" AppendDataBoundItems="True" DataSourceID="Scope_SqlDataSource" DataTextField="MAT_SCOPE"
                        DataValueField="MAT_SCOPE_CODE" Width="150px">
                        <asp:ListItem Value="-1" Text=""></asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddScope" ErrorMessage="*" ForeColor="Red" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                </td>
            </tr>
             <tr>
                <td class="Heading">
                    <asp:Label ID="Label4" runat="server" Text="Issue By"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtIssueBy" runat="server" Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">
                    <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="200px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="FromSubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR
WHERE (PROJ_ID = :PROJECT_ID)
 ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="ToSubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR
WHERE (PROJ_ID = :PROJECT_ID) AND PAINT_SC = 'Y'
 ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Scope_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_SCOPE_CODE, MAT_SCOPE FROM MATERIAL_SCOPE WHERE (PROJECT_ID = :PROJECT_ID)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPaintSystem" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT LINE_PS FROM PIP_ISOMETRIC WHERE LINE_PS IS NOT NULL ORDER BY LINE_PS "></asp:SqlDataSource>
</asp:Content>