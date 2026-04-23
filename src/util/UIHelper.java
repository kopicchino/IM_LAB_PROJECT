package util;

import javax.swing.*;
import javax.swing.border.EmptyBorder;
import java.awt.*;

public class UIHelper {
    // Modern Color Palette
    public static final Color PRIMARY_COLOR = new Color(59, 130, 246); // Blue
    public static final Color SECONDARY_COLOR = new Color(99, 102, 241); // Indigo
    public static final Color SUCCESS_COLOR = new Color(34, 197, 94); // Green
    public static final Color DANGER_COLOR = new Color(239, 68, 68); // Red
    public static final Color WARNING_COLOR = new Color(251, 146, 60); // Orange
    public static final Color INFO_COLOR = new Color(14, 165, 233); // Cyan
    
    public static final Color SIDEBAR_BG = new Color(30, 41, 59); // Slate 800
    public static final Color CONTENT_BG = new Color(248, 250, 252); // Slate 50
    public static final Color CARD_BG = Color.WHITE;
    public static final Color TEXT_PRIMARY = new Color(15, 23, 42); // Slate 900
    public static final Color TEXT_SECONDARY = new Color(100, 116, 139); // Slate 500
    public static final Color BORDER_COLOR = new Color(226, 232, 240); // Slate 200
    
    public static Font HEADER_FONT = new Font("Segoe UI", Font.BOLD, 24);
    public static Font SUBHEADER_FONT = new Font("Segoe UI", Font.BOLD, 18);
    public static Font NORMAL_FONT = new Font("Segoe UI", Font.PLAIN, 14);
    public static Font BUTTON_FONT = new Font("Segoe UI", Font.BOLD, 14);
    
    public static JButton createPrimaryButton(String text) {
        JButton button = new JButton(text);
        styleButton(button, PRIMARY_COLOR, Color.WHITE);
        return button;
    }
    
    public static JButton createSuccessButton(String text) {
        JButton button = new JButton(text);
        styleButton(button, SUCCESS_COLOR, Color.WHITE);
        return button;
    }
    
    public static JButton createDangerButton(String text) {
        JButton button = new JButton(text);
        styleButton(button, DANGER_COLOR, Color.WHITE);
        return button;
    }
    
    public static JButton createSecondaryButton(String text) {
        // Secondary buttons now use a filled style for consistency (indigo background, white text)
        JButton button = new JButton(text);
        styleButton(button, SECONDARY_COLOR, Color.WHITE);
        return button;
    }
    
    private static void styleButton(JButton button, Color bgColor, Color fgColor) {
        button.setFont(BUTTON_FONT);
        button.setBackground(bgColor);
        button.setForeground(fgColor);
        button.setBorder(new EmptyBorder(10, 20, 10, 20));
        button.setFocusPainted(false);
        button.setCursor(new Cursor(Cursor.HAND_CURSOR));
        button.setOpaque(true);
        button.setContentAreaFilled(true);
        button.setBorderPainted(false);
        
        button.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                button.setBackground(bgColor.darker());
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                button.setBackground(bgColor);
            }
        });
    }
    
    public static JPanel createCard() {
        JPanel card = new JPanel();
        card.setBackground(CARD_BG);
        card.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(BORDER_COLOR, 1),
            new EmptyBorder(20, 20, 20, 20)
        ));
        return card;
    }
    
    public static JTextField createTextField() {
        JTextField field = new JTextField();
        field.setFont(NORMAL_FONT);
        field.setBorder(BorderFactory.createCompoundBorder(
            BorderFactory.createLineBorder(BORDER_COLOR, 1),
            new EmptyBorder(8, 12, 8, 12)
        ));
        return field;
    }
    
    public static JLabel createLabel(String text) {
        JLabel label = new JLabel(text);
        label.setFont(NORMAL_FONT);
        label.setForeground(TEXT_PRIMARY);
        return label;
    }
    
    public static JLabel createHeaderLabel(String text) {
        JLabel label = new JLabel(text);
        label.setFont(HEADER_FONT);
        label.setForeground(TEXT_PRIMARY);
        return label;
    }
    
    public static JLabel createSubHeaderLabel(String text) {
        JLabel label = new JLabel(text);
        label.setFont(SUBHEADER_FONT);
        label.setForeground(TEXT_PRIMARY);
        return label;
    }

    /**
     * Create a button styled like the sidebar/menu buttons in MainFrame
     */
    public static JButton createMenuButton(String text) {
        JButton btn = new JButton(text);
        btn.setFont(new Font("Segoe UI", Font.PLAIN, 15));
        // Match MainFrame sidebar/menu button style: light foreground on dark bg, flat appearance
        btn.setForeground(new Color(203, 213, 225)); // Slate 300
        btn.setBackground(SIDEBAR_BG);
        btn.setHorizontalAlignment(SwingConstants.LEFT);
        btn.setBorder(new EmptyBorder(12, 25, 12, 25));
        btn.setMaximumSize(new Dimension(250, 45));
        btn.setFocusPainted(false);
        btn.setCursor(new Cursor(Cursor.HAND_CURSOR));
        btn.setContentAreaFilled(false);
        btn.setOpaque(true);

        btn.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseEntered(java.awt.event.MouseEvent evt) {
                if (!btn.getBackground().equals(PRIMARY_COLOR)) {
                    btn.setBackground(new Color(51, 65, 85)); // Slate 700
                }
            }
            public void mouseExited(java.awt.event.MouseEvent evt) {
                if (!btn.getBackground().equals(PRIMARY_COLOR)) {
                    btn.setBackground(SIDEBAR_BG);
                }
            }
        });

        return btn;
    }
    
    public static void styleTable(JTable table) {
        table.setFont(NORMAL_FONT);
        table.setRowHeight(40);
        table.setGridColor(BORDER_COLOR);
        table.setSelectionBackground(new Color(219, 234, 254)); // Blue 100
        table.setSelectionForeground(TEXT_PRIMARY);
        table.getTableHeader().setFont(new Font("Segoe UI", Font.BOLD, 14));
        table.getTableHeader().setBackground(CONTENT_BG);
        table.getTableHeader().setForeground(TEXT_PRIMARY);
        table.getTableHeader().setBorder(BorderFactory.createMatteBorder(0, 0, 2, 0, BORDER_COLOR));
    }
    
    public static void showSuccess(Component parent, String message) {
        JOptionPane.showMessageDialog(parent, message, "Success", JOptionPane.INFORMATION_MESSAGE);
    }
    
    public static void showError(Component parent, String message) {
        JOptionPane.showMessageDialog(parent, message, "Error", JOptionPane.ERROR_MESSAGE);
    }
    
    public static boolean showConfirm(Component parent, String message) {
        return JOptionPane.showConfirmDialog(parent, message, "Confirm", 
            JOptionPane.YES_NO_OPTION, JOptionPane.QUESTION_MESSAGE) == JOptionPane.YES_OPTION;
    }
}