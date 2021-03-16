<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="RT100New.aspx.cs" Inherits="WeldingInspec_JointPaintNew" Title="New" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 4px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 200px; background-color: gainsboro;">Welder No</td>
                <td>

                    <asp:DropDownList ID="ddWelderNos" runat="server" DataSourceID="weldersDataSource"
                        DataTextField="WELDER_NO" DataValueField="WELDER_ID" Width="100px" AppendDataBoundItems="True"
                        OnDataBinding="ddWelderNos_DataBinding" OnSelectedIndexChanged="ddWelderNos_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="WelderNoValidator" runat="server" ControlToValidate="ddWelderNos"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 200px; background-color: gainsboro;">First Joint Isometric No</td>
                <td>
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged"
                        EmptyMessage="Isometric No" Width="250px">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="IsomeValidator" runat="server" ControlToValidate="txtIsome"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 200px; background-color: gainsboro;">First Joint No
                </td>
                <td>
                    <asp:DropDownList ID="cboNewJoint" runat="server" DataSourceID="newjointDataSource"
                        DataTextField="JNT_TITLE" DataValueField="JOINT_ID" Width="350px"
                        AppendDataBoundItems="True" OnDataBinding="cboNewJoint_DataBinding">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="JointNoValidator" runat="server" ControlToValidate="cboNewJoint"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 200px; background-color: gainsboro; height: 29px;">Rejected Isometric No</td>
                <td>
                    <telerik:RadTextBox ID="txtRejIsoNo" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged"
                        EmptyMessage="Isometric No" Width="250px">
                    </telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtRejIsoNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 200px; background-color: gainsboro;">Rejected Joint No
                </td>
                <td>
                    <asp:DropDownList ID="cboRejJoint" runat="server" DataSourceID="rejjointDataSource"
                        DataTextField="JNT_TITLE" DataValueField="JOINT_ID" Width="350px"
                        AppendDataBoundItems="True" OnDataBinding="cboRejJoint_DataBinding">
                    </asp:DropDownList>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboRejJoint"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 200px; background-color: gainsboro;">
                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="454px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="weldersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELDER_ID, WELDER_NO FROM PIP_WELDERS WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY WELDER_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="newjointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, JNT_TITLE FROM VIEW_JOINTS_SIMPLE_WELDING
WHERE (ISO_TITLE1 = :ISO_TITLE1)
AND (PROJ_ID = :PROJECT_ID)
AND (WELD_DATE IS NOT NULL)
ORDER BY ISO_ID, FNC_JNT_NO_DEC(JOINT_NO)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="rejjointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, JNT_TITLE FROM VIEW_JOINTS_SIMPLE_WELDING
WHERE (ISO_TITLE1 = :ISO_TITLE1)
AND (PROJ_ID = :PROJECT_ID)
AND (WELD_DATE IS NOT NULL)
ORDER BY ISO_ID, FNC_JNT_NO_DEC(JOINT_NO)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtRejIsoNo" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>