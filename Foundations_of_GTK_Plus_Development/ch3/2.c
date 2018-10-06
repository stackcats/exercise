#include <gtk-3.0/gtk/gtk.h>

#define PAGE_SIZE 4

static void previous_tab(GtkWidget *widget, gpointer notebook) {
  gint currentPage = gtk_notebook_get_current_page(GTK_NOTEBOOK(notebook));
  gint totalPages = gtk_notebook_get_n_pages(GTK_NOTEBOOK(notebook));
  gint targetPage = (currentPage - 1 + totalPages) % totalPages;
  gtk_notebook_set_current_page(GTK_NOTEBOOK(notebook), targetPage);
}

static void next_tab(GtkWidget *widget, gpointer notebook) {
  gint currentPage = gtk_notebook_get_current_page(GTK_NOTEBOOK(notebook));
  gint totalPages = gtk_notebook_get_n_pages(GTK_NOTEBOOK(notebook));
  gint targetPage = (currentPage + 1) % totalPages;
  gtk_notebook_set_current_page(GTK_NOTEBOOK(notebook), targetPage);
}


int main(int argc, char *argv[]) {
  gtk_init(&argc, &argv);

  GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(window), "Exercise 3-1");
  gtk_container_set_border_width(GTK_CONTAINER(window), 10);
  gtk_widget_set_size_request(window, 200, 100);
  g_signal_connect(G_OBJECT(window), "destroy", G_CALLBACK(gtk_main_quit), NULL);

  GtkWidget *paned = gtk_paned_new(GTK_ORIENTATION_VERTICAL);
  gtk_container_add(GTK_CONTAINER(window), paned);
  
  GtkWidget *notebook = gtk_notebook_new();
  gtk_paned_add1(GTK_PANED(paned), notebook);
  for (int i = 0; i < PAGE_SIZE; i++) {    
    char s[64];
    sprintf(s, "Page %d", i);
    GtkWidget *label = gtk_label_new(s);
    GtkWidget *expander = gtk_expander_new(s);
    sprintf(s, "Button %d", i);
    GtkWidget *button = gtk_button_new_with_label(s);
    gtk_container_add(GTK_CONTAINER(expander), button);
    gtk_notebook_append_page(GTK_NOTEBOOK(notebook), expander, label);
    g_signal_connect(G_OBJECT(button), "clicked", G_CALLBACK(next_tab), (gpointer)notebook);
  }

  gtk_notebook_set_show_tabs(GTK_NOTEBOOK(notebook), FALSE);
  
  GtkWidget *hbox = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 10);
  gtk_paned_add2(GTK_PANED(paned), hbox);
  GtkWidget *prevButton = gtk_button_new_with_label("Prev");
  GtkWidget *nextButton = gtk_button_new_with_label("Next");
  gtk_box_pack_start(GTK_BOX(hbox), prevButton, TRUE, FALSE, 5);
  gtk_box_pack_start(GTK_BOX(hbox), nextButton, TRUE, FALSE, 5);
  g_signal_connect(G_OBJECT(prevButton), "clicked", G_CALLBACK(previous_tab), (gpointer)notebook);
  g_signal_connect(G_OBJECT(nextButton), "clicked", G_CALLBACK(next_tab), (gpointer)notebook);
  
  gtk_widget_show_all(window);
  
  gtk_main();
  return 0;
}
